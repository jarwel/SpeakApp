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
    
    private var task: URLSessionWebSocketTask
    
    var delegate: SpeakServiceDelegate?
    
    private override init() {
        var request = URLRequest(url: Self.url)
        request.addValue(Self.accessToken, forHTTPHeaderField: "x-access-token")
        request.addValue(Self.clientInfo, forHTTPHeaderField: "x-client-info")
        task = URLSession.shared.webSocketTask(with: request)
        
        super.init()
        task.delegate = self
        task.resume()
        listen { [weak self] text in
            self?.delegate?.onTranslationRecieved(text)
        }
    }
    
    func start(learningLocale: Locale) {
        let event = AsrStartEvent(learningLocale: learningLocale.identifier)
        
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
    
    func listen(callback: @escaping (String) -> Void)  {
        task.receive { result in
            switch result {
            case .failure(let error):
                print("failure")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Text: \(text)")
                case .data(let data):
                    print("Data: \(data)")
                @unknown default:
                    fatalError()
                }
                callback("Test")
            }
        }
    }
    
    private func send(data: Data) {
        let message = URLSessionWebSocketTask.Message.data(data)
        task.send(message) { error in
            if let error = error {
                print("Error sending message: \(error)")
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
