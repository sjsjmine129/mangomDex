//
//  ViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class ProductViewController: UIViewController {
    
    // MARK - UI
    private lazy var tableViewProduct : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor(resource: .magClothes)
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(ProoductTableViewCell.self, forCellReuseIdentifier: ProoductTableViewCell.cellId)
        tv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        return tv
    }()
    
    private lazy var productViewModel = ProductViewModel()
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        setNavigationBar()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(resource: .magClothes)
    }
    
}

// MARK: -set UI
private extension ProductViewController{
    //set navigation Bar UI of product tab
    func setNavigationBar(){
        let title = UILabel()
        title.text = "망그러진 상품"
        title.font = UIFont(name: "HUDdiu150", size: 25)
        title.textColor = UIColor(resource: .textBlack)
        
        let barButton = UIBarButtonItem(customView: title)
        
        navigationItem.leftBarButtonItem = barButton
        self.navigationController?.navigationBar.barTintColor = .magClothes
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    //set UI
    func setup(){
        tableViewProduct.dataSource = self
        self.view.addSubview(tableViewProduct)
        
        NSLayoutConstraint.activate([
            tableViewProduct.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableViewProduct.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableViewProduct.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableViewProduct.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}


// MARK - UITableViewDataSource
extension ProductViewController: UITableViewDataSource{
    // num of colunm
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productViewModel.products[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProoductTableViewCell.cellId , for: indexPath) as! ProoductTableViewCell
        cell.cellConfigure(delegate: self)
        productViewModel.setProductCell(cell: cell, index: indexPath.row)
        
        cell.imgVwProduct.image = UIImage(named: "\(product.name).jpeg")
        
        return cell
    }
    
}

extension ProductViewController: ProductTableCellDelegate{
    func didTapButton(for CUlink: String?) {
        if let navigationController = self.navigationController {
            let nextPage = ProductDetailViewController()
            nextPage.CUlinkData = CUlink
            navigationController.pushViewController(nextPage, animated: true)
        }
    }
}
