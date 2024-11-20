//
//  AsrClient.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

class AsrClient: NSObject, SpeakService {
    static let shared = AsrClient()
    
    private static let url = URL(string: "wss://speak-api--feature-mobile-websocket-interview.preview.usespeak.dev/v2/ws")!
    
    private static let accessToken = "DFKKEIO23DSAvsdf"
    private static let clientInfo = "Speak Interview Test"
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var task: URLSessionWebSocketTask
    
    var delegate: SpeakServiceDelegate?
    var isRecording: Bool
    
    private override init() {
        var request = URLRequest(url: Self.url)
        request.addValue(Self.accessToken, forHTTPHeaderField: "x-access-token")
        request.addValue(Self.clientInfo, forHTTPHeaderField: "x-client-info")
        task = URLSession.shared.webSocketTask(with: request)
        isRecording = false
        
        super.init()
        task.delegate = self
        connect()
    }
    
    func start(learningLocale: Locale) {
        let event = AsrStartEvent(learningLocale: learningLocale.identifier(.bcp47))
        do {
            let data = try encoder.encode(event)
            send(data: data)
        } catch {
            print("Encoder error: \(error.localizedDescription)")
        }
    }

    
    func stream(event: AsrStreamEvent) {
        do {
            let data = try encoder.encode(event)
            send(data: data)
        } catch {
            print("Encoder error: \(error.localizedDescription)")
        }
    }
    
    func listen() {
        task.receive { [weak self] message in
            switch message {
            case .failure(let error):
                print("WebSocket error: \(error.localizedDescription)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Text: \(text)")
                    if let data = text.data(using: .utf8) {
                        do {
                            let event = try self?.decoder.decode(AsrResultEvent.self, from: data)
                            self?.delegate?.onTranslationRecieved("Test", isFinal: event?.isFinal ?? true)
                            self?.listen()
                            print(event?.type)
                        } catch {
                            print("Decoder error: \(error.localizedDescription)")
                        }
                    }
                case .data(let data):
                    print("Data: \(data)")
                    //decoder.decode(AsrMetadataEvent.self, from: data)
                    
                @unknown default:
                    fatalError()
                }
               // let data = try Data(contentsOf: message.
                //let event = try decoder.decode(AsrResultEvent.self, from: data)
            }
        }
    }
    
    private func connect() {
        task.resume()
        listen()
    }
    
    private func disconnect() {
        task.cancel(with: .goingAway, reason: nil)
    }
    
    private func send(data: Data) {
        let message = URLSessionWebSocketTask.Message.data(data)
        task.send(message) { error in
            if let error = error {
                print("WebSocket send error: \(error.localizedDescription)")
            }
        }
    }
}

extension AsrClient: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocket connection opened")
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket connection closed: \(closeCode.rawValue), reason: \(reason?.base64EncodedString() ?? "unknown")")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            print("WebSocket task completed with error: \(error)")
        }
    }
}
