//
//  CourseTableViewController.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/9/24.
//

import UIKit


class CourseTableViewController: UIViewController {
    @IBOutlet weak var headerView: CourseHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    private static let tableCellReuseIdentifier = "CourseTableViewCell"
    private static let tableHeaderReuseIdentifier = "CourseTableViewHeaderView"
    private static let headerBackground = UIImage(named: "Header")!
    
    let viewModel = CourseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        viewModel.fetchCourse()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerView.backgroundColor = UIColor(patternImage: Self.headerBackground)
        if let course = viewModel.course {
            headerView.titleLabel.text =  course.info.title
            headerView.subtitleLabel.text = course.info.subtitle
            viewModel.image(for: course){ [weak self] image in
                self?.headerView.thumbnailImageView.image = image
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.tableCellReuseIdentifier, for: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.tableCellReuseIdentifier, for: indexPath) as? CourseTableViewCell else {
            return cell
        }
        
        if let day = viewModel.course?.units[indexPath.section].days[indexPath.row] {
            cell.dayLabel.text = day.formattedId
            cell.titleLabel.font = .preferredFont(forTextStyle: .headline)
            cell.titleLabel.text =  day.title
            cell.subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
            cell.subtitleLabel.text = day.subtitle
            cell.thumbnailImageView.image = nil
            
            // Crop image to circle
            cell.thumbnailImageView.clipsToBounds = true
            cell.thumbnailImageView.layer.masksToBounds = true
            cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.height / 2
            
            viewModel.image(for: day) { image in
                // Only update the image if cell has not been reused
                if indexPath == tableView.indexPath(for: cell) {
                    cell.thumbnailImageView.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: Self.tableHeaderReuseIdentifier) as? CourseTableViewHeaderView else {
            return nil
        }
        
        if let unit = viewModel.course?.units[section] {
            headerView.titleLabel.text = unit.formattedId
            headerView.thumbnailImageView.image = viewModel.image(for: unit)
        }
        return headerView
    }
}

extension CourseTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = RecordHostingController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

