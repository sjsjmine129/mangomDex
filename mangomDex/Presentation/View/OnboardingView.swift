//
//  OnboardingView.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import UIKit

class OnboardingView: UIView{
    
    lazy var vwMain: UIView = {
        var vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    lazy var vwColor: UIView = {
        var vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .black
        vw.alpha = 0.7
        
        return vw
    }()
    
    
    lazy var lblTwoTap: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Pretendard-SemiBold", size: 30)
        lbl.textColor = UIColor(resource: .hamWhite)
        lbl.text = "2번 탭해서\n띠부씰 수집!"
        lbl.numberOfLines = 2
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var lblLongPress: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Pretendard-SemiBold", size: 30)
        lbl.textColor = UIColor(resource: .hamWhite)
        lbl.text = "꾹 눌러서\n개수 초기화!"
        lbl.numberOfLines = 2
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var imgVw04: UIImageView = {
        var imgVw = UIImageView(image: UIImage(named: "4.jpg"))
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        imgVw.alpha = 0.9
        
        return imgVw
    }()
    
    lazy var imgVw24: UIImageView = {
        var imgVw = UIImageView(image: UIImage(named: "24.jpg"))
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        imgVw.alpha = 0.9
        
        return imgVw
    }()
    
    lazy var imgVwPoint1: UIImageView = {
        var imgVw = UIImageView(image: UIImage(named: "pointing.png"))
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.autoreverse, .repeat], animations: {
            imgVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { timer in
            if imgVw.alpha == 1{
                imgVw.alpha = 0
            }
            else{
                imgVw.alpha = 1
            }
        }
        
        return imgVw
    }()
    

    lazy var imgVwPoint2: UIImageView = {
        var imgVw = UIImageView(image: UIImage(named: "pointing.png"))
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat], animations: {
            imgVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            imgVw.alpha = 0.3
        }, completion: nil)
        
        return imgVw
    }()

    
    lazy var  lblbtnClose: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 20)
        label.textColor = UIColor(resource: .textBlack)
        label.text = "띠부씰 모으러 가기!"
        
        return label
    }()
    
    lazy var btnClose: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(lblbtnClose)
        btn.backgroundColor = .magBody
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor(resource: .magBorder).cgColor
        
        NSLayoutConstraint.activate([
            //lblbtnClose
            lblbtnClose.topAnchor.constraint(equalTo: btn.topAnchor, constant: 10),
            lblbtnClose.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 18),
            lblbtnClose.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -18),
            lblbtnClose.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: -10),
        ])
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(vwColor)
        addSubview(vwMain)
        addSubview(btnClose)
        
        vwMain.addSubview(lblTwoTap)
        vwMain.addSubview(imgVw04)
        vwMain.addSubview(imgVwPoint1)
        vwMain.addSubview(lblLongPress)
        vwMain.addSubview(imgVw24)
        vwMain.addSubview(imgVwPoint2)
        
        NSLayoutConstraint.activate([
            //vwColor
            vwColor.topAnchor.constraint(equalTo: topAnchor),
            vwColor.leadingAnchor.constraint(equalTo: leadingAnchor),
            vwColor.trailingAnchor.constraint(equalTo: trailingAnchor),
            vwColor.bottomAnchor.constraint(equalTo: bottomAnchor),
            //vwMain
            vwMain.centerXAnchor.constraint(equalTo: vwColor.centerXAnchor),
            vwMain.centerYAnchor.constraint(equalTo: vwColor.centerYAnchor),
            //lblTwoTap
            lblTwoTap.leadingAnchor.constraint(equalTo: vwMain.leadingAnchor),
            //imgVw04
            imgVw04.heightAnchor.constraint(equalToConstant: 130),
            imgVw04.widthAnchor.constraint(equalToConstant: 100),
            imgVw04.leadingAnchor.constraint(equalTo: lblTwoTap.trailingAnchor, constant: 20),
            imgVw04.topAnchor.constraint(equalTo: vwMain.topAnchor, constant: 0),
            imgVw04.bottomAnchor.constraint(equalTo: lblTwoTap.centerYAnchor, constant: 20),
            //imgVwPoint1
            imgVwPoint1.heightAnchor.constraint(equalToConstant: 200),
            imgVwPoint1.widthAnchor.constraint(equalToConstant: 120),
            imgVwPoint1.trailingAnchor.constraint(equalTo: vwMain.trailingAnchor,constant: 0),
            imgVwPoint1.topAnchor.constraint(equalTo: imgVw04.bottomAnchor, constant: -50),
            imgVwPoint1.leadingAnchor.constraint(equalTo: imgVw04.trailingAnchor, constant: -60),
            //imgVw24
            imgVw24.heightAnchor.constraint(equalToConstant: 130),
            imgVw24.widthAnchor.constraint(equalToConstant: 100),
            imgVw24.leadingAnchor.constraint(equalTo: vwMain.leadingAnchor, constant: 10),
            imgVw24.topAnchor.constraint(equalTo: imgVwPoint1.bottomAnchor, constant: -50),
            //imgVwPoint2
            imgVwPoint2.heightAnchor.constraint(equalToConstant: 200),
            imgVwPoint2.widthAnchor.constraint(equalToConstant: 120),
            imgVwPoint2.bottomAnchor.constraint(equalTo: vwMain.bottomAnchor,constant: 0),
            imgVwPoint2.topAnchor.constraint(equalTo: imgVw24.bottomAnchor, constant: -50),
            imgVwPoint2.leadingAnchor.constraint(equalTo: imgVw24.trailingAnchor, constant: -60),
            //lblLongPress
            lblLongPress.centerYAnchor.constraint(equalTo: imgVw24.bottomAnchor, constant: -20),
            lblLongPress.leadingAnchor.constraint(equalTo: imgVwPoint2.trailingAnchor, constant: 0),
            lblLongPress.trailingAnchor.constraint(equalTo: vwMain.trailingAnchor, constant: 0),
            //btnClose
            btnClose.centerXAnchor.constraint(equalTo: vwColor.centerXAnchor),
            btnClose.topAnchor.constraint(equalTo: vwMain.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
