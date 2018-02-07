//
//  ViewController.swift
//  KLayout
//
//  Created by Rick Ke on 2017/12/20.
//  Copyright © 2017年 RickKe. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    let buleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    let cyanView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(buleView)

        makeLayoutConstraint()
        
        view.addSubview(cyanView) { make in
            make.kLayoutCenter(equalTo: buleView)
            make.kLayoutHeight(equalTo: buleView)
            make.kLayoutHorizontalRatio(0.5)
        }

    }

    func makeLayoutConstraint() {
        redView.makeLayout { make in
            make.kLayout(.top, equalTo: view)
            make.kLayout(.left, equalTo: view)
            make.kLayout(.right, equalTo: view)
            make.kLayout(.height, equalTo: view).multi(0.5)
        }
        greenView.makeLayout { make in
            make.kLayoutInsets(UIEdgeInsets.init(top: 50, left: 50, bottom: 50, right: 50), to: redView)
        }
        buleView.makeLayout { make in
            make.kLayout(.top, equalTo: redView, .bottom)
            make.kLayout(.left, equalTo: view).inset(20)
            make.kLayout(.right, equalTo: view).inset(20)
            make.kLayout(.bottom, equalTo: view).inset(50)
        }

    }
    
}


