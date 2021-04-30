//
//  ViewController.swift
//  ExampleMVVM
//
//  Created by mbtec22 on 4/29/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    var viewModel = ViewModelPost()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }

    func configureView(){
        indicatorActivity.isHidden = false
        indicatorActivity.startAnimating()
        viewModel.getDataPost()
        
    }
    
    func bind(){
    viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.indicatorActivity.isHidden = true
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArrayPost.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let object = viewModel.dataArrayPost[indexPath.row]
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.body
        return cell
    }
    
}
