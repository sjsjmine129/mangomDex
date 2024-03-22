//
//  ProductDetailViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 3/7/24.
//

import UIKit
import WebKit

class ProductDetailViewController: UIViewController, WKNavigationDelegate {
    
    var CUlinkData: String?
    
    private lazy var webView: WKWebView = {
        let wV = WKWebView(frame: UIScreen.main.bounds)
        wV.translatesAutoresizingMaskIntoConstraints = false
        wV.navigationDelegate = self
        
        // Load a webpage
        if let cuLinkData = CUlinkData, let url = URL(string: cuLinkData) {
            let request = URLRequest(url: url)
            wV.load(request)
        }
        
        return wV
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var btnGobackHidden: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hamWhite
        
        navigationController?.navigationBar.barStyle = .default
        
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        view.addSubview(btnGobackHidden)
        
        NSLayoutConstraint.activate([
            //webView
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //btnGobackHidden
            btnGobackHidden.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            btnGobackHidden.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            btnGobackHidden.heightAnchor.constraint(equalToConstant: 40),
            btnGobackHidden.widthAnchor.constraint(equalToConstant: 40),
            //activityIndicator
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

// MARK: - webView setting
extension ProductDetailViewController{
    // Implement WKNavigationDelegate method to handle navigation
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .backForward {
            if webView.canGoBack {
                webView.goBack()
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}

extension ProductDetailViewController: UIGestureRecognizerDelegate{
    
}
