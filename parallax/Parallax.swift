//
//  Parallax.swift
//  parallax
//
//  Created by C4Q on 1/9/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class Parallax: UIView {
    
    public var numberOfScreens: CGFloat = 3
    var contentViewBoundsWidth: CGFloat!
    var maxContentOffset: CGFloat!
    var maxBackgroundOffset: CGFloat!
    var page: Int = 1

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupScreen1Label()
        setupScreen2Label()
        setupScreen3Label()
        setupImageView()
        setupContentView()
        setupBackgroundScrollView()
        setupContentScrollView()
        thing()
        
    }
    
    func thing() {
        contentViewBoundsWidth = contentView.bounds.width
        maxContentOffset = maxOffsetForScrollView(scrollView: contentScrollView)
        maxBackgroundOffset = maxOffsetForScrollView(scrollView: backgroundScrollView)
    }
    
    func maxOffsetForScrollView(scrollView: UIScrollView) -> CGFloat {
        let contentWidth: CGFloat = scrollView.contentSize.width - 100
        let frameWidth: CGFloat = self.bounds.width
        return contentWidth - frameWidth
    }
    
    //All UIElement
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width * CGFloat(self.numberOfScreens), height: self.bounds.height))
        return view
    }()
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = .clear
        scrollView.contentSize = contentView.bounds.size
        return scrollView
    }()
    
    lazy var backgroundScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = .white
        scrollView.contentSize = backImageView.bounds.size
        scrollView.setContentOffset(CGPoint.init(x: 1/3 , y: 0), animated: true)

        return scrollView
    }()
    
    lazy var backImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "original")
        iv.frame = CGRect(x: 0, y: 0, width: self.bounds.width * 3 / 2 , height: self.bounds.height)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var screen1Label: UILabel = { //first label
        let label = UILabel()
        label.frame = CGRect(x: ((contentView.bounds.width / (numberOfScreens * 2)) - 100), y: 0, width: 200, height: 200)
        label.text = "Screen 1"
        label.textAlignment = .center
        return label
    }()
    
    lazy var screen2Label: UILabel = { //middle label
        let label = UILabel()
        label.frame = CGRect(x: (contentView.bounds.width / 2) - 100, y: 0, width: 200, height: 200)
        label.text = "Screen 2"
        label.textAlignment = .center
        return label
    }()
    
    lazy var screen3Label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: ((contentView.bounds.width / 6) * 5) - 100 , y: 0, width: 200, height: 200)
        label.text = "Screen 3"
        label.textAlignment = .center
        return label
    }()
    
    func setupImageView() {
        addSubview(backImageView)
    }
    
    func setupContentView() {
        addSubview(contentView)
        contentView.addSubview(screen1Label)
        contentView.addSubview(screen2Label)
        contentView.addSubview(screen3Label)
    }
    
    func setupContentScrollView() {
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
    }
    
    func setupBackgroundScrollView() {
        addSubview(backgroundScrollView)
        backgroundScrollView.addSubview(backImageView)
    }
    
    func setupScreen1Label() {
        addSubview(screen1Label)
    }
    
    func setupScreen2Label() {
        addSubview(screen2Label)
    }
    
    func setupScreen3Label() {
        addSubview(screen3Label)
    }
    
}
