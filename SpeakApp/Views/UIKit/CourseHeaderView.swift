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
    
    private static let headerBackground = UIImage(named: "Header")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(patternImage: Self.headerBackground)
        titleLabel.font = .preferredFont(forTextStyle: .extraLargeTitle2)
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        // Crop image to circle
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.height / 2
    }
}
