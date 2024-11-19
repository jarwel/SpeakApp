//
//  CourseHeaderView.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/18/24.
//

import UIKit

class CourseHeaderView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    private static let backgroundImage = UIImage(named: "Header")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .preferredFont(forTextStyle: .extraLargeTitle2)
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        // Crop image to circle
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.height / 2
        
        // Add image to background
        let backgoundView = UIImageView(image: Self.backgroundImage)
        backgoundView.contentMode = .scaleAspectFill
        backgoundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgoundView)
        sendSubviewToBack(backgoundView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: backgoundView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgoundView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgoundView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgoundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ])
    }
}
