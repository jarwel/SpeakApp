//
//  CourseTableViewController.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/9/24.
//

import UIKit


class CourseTableViewController: UIViewController {
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = CourseViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetch()
        if let info = viewModel.course?.info {
            titleLabel.font = .preferredFont(forTextStyle: .headline)
            titleLabel.text =  info.title
            subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
            subtitleLabel.text = info.subtitle
            viewModel.imageForUrl(info.thumbnailImageUrl) { [weak self] image in
                self?.thumbnailImageView.image = image
            }
        }
        tableView.reloadData()
    }
}

extension CourseTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.course?.units.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.course?.units[section].days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTableViewCell", for: indexPath)
        guard let cell = cell as? CourseTableViewCell else {
            return cell
        }
        guard let day = viewModel.course?.units[indexPath.section].days[indexPath.row] else {
            return cell
        }
    
        cell.titleLabel.font = .preferredFont(forTextStyle: .headline)
        cell.titleLabel.text =  day.title
        cell.subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        cell.subtitleLabel.text = day.subtitle
        cell.tumbnailImageView.image = nil
        viewModel.imageForUrl(day.thumbnailImageUrl) { image in
            // Only update the image if cell has not been reused
            if indexPath == tableView.indexPath(for: cell) {
                cell.tumbnailImageView.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.course?.units[section].id
    }
}

extension CourseTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = RecordHostingController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

