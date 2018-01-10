//
//  ViewController.swift
//  parallax
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var backgroundScrollView: UIScrollView!//
//    var contentScrollView: UIScrollView!//
//    var imageView: UIImageView!//
//    var contentView: UIView!//
//    var maxContentOffset: CGFloat!
//    var maxBackgroundOffset: CGFloat!
//    var cvbw: CGFloat!
//    var page: Int = 1
    
    let parallaxView = Parallax()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        parallaxView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)

        view.addSubview(parallaxView)
        
//        parallaxView.translatesAutoresizingMaskIntoConstraints = false
//        [parallaxView.topAnchor.constraint(equalTo: self.view.topAnchor),
//         parallaxView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//         parallaxView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//         parallaxView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]
//            .forEach{$0.isActive = true}
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        self.createBackground()
//        self.createContent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        parallaxView.contentScrollView.delegate = self
        parallaxView.backgroundScrollView.delegate = self
    }
    
//
//
//    func createBackground() {
//        imageView = UIImageView(image: #imageLiteral(resourceName: "original"))
//        imageView.contentMode = .scaleAspectFill
////        ((self.view.bounds.height/2668) * 2500)
//        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 3 / 2, height: view.bounds.height)
//        backgroundScrollView = UIScrollView(frame: view.bounds)
//        backgroundScrollView.backgroundColor = UIColor.blue
//        backgroundScrollView.contentSize = imageView.bounds.size
    
//        backgroundScrollView.addSubview(imageView)
//        view.addSubview(backgroundScrollView)
    
//        maxBackgroundOffset = maxOffsetForScrollView(scrollView: backgroundScrollView)
//    }
//
//    func createContent() {
//        contentView = UIView(frame: CGRect(x: 0, y: 0, width: (view.bounds.width * 3), height: view.bounds.height))
//        contentScrollView = UIScrollView(frame: view.bounds)
//        contentScrollView.backgroundColor = UIColor.clear
//        contentScrollView.contentSize = contentView.bounds.size
//
//        maxContentOffset = maxOffsetForScrollView(scrollView: contentScrollView)
//        cvbw = contentView.bounds.width
//
//        let firstButton = UIButton()
//        firstButton.frame = CGRect(x: ((contentView.bounds.width / 6) - 150), y: 300, width: 300, height: 100)
//        firstButton.setTitle("Scroll", for: .normal)
//        firstButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        firstButton.addTarget(self, action: #selector(firstAction), for: .touchUpInside)
//
//        let firstLabel = UILabel()
//        firstLabel.frame = CGRect(x: ((contentView.bounds.width / 6) - 100), y: 0, width: 200, height: 200)
//        firstLabel.text = "Screen 1"
//        firstLabel.textAlignment = .center
//
//        let secondLabel = UILabel()
//        secondLabel.frame = CGRect(x: (contentView.bounds.width / 2) - 100, y: 0, width: 200, height: 200)
//        secondLabel.text = "Screen 2"
//        secondLabel.textAlignment = .center
//
//        let thirdLabel = UILabel()
//        thirdLabel.frame = CGRect(x: ((contentView.bounds.width / 6) * 5) - 100 , y: 0, width: 200, height: 200)
//        thirdLabel.text = "Screen 3"
//        thirdLabel.textAlignment = .center
//
//        contentView.addSubview(firstButton)
//        contentView.addSubview(firstLabel)
//        contentView.addSubview(secondLabel)
//        contentView.addSubview(thirdLabel)
//        contentScrollView.addSubview(contentView)
//        view.addSubview(contentScrollView)
//    }
//
//    func maxOffsetForScrollView(scrollView: UIScrollView) -> CGFloat {
//        let contentWidth: CGFloat = scrollView.contentSize.width - 100
//        let frameWidth: CGFloat = view.bounds.width
//        return contentWidth - frameWidth
//    }
//
//
//    @objc func firstAction (sender: UIButton) {
//        print("firstAction")
//        self.contentScrollView.setContentOffset(CGPoint(x: cvbw / 3, y: 0), animated: true)
//    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if parallaxView.page == 1 {
            if scrollView.contentOffset.x > 0 {
                scrollView.setContentOffset(CGPoint(x: (parallaxView.contentViewBoundsWidth / 3), y: 0), animated: true)
            }
        } else if parallaxView.page == 2 {
            if scrollView.contentOffset.x < (parallaxView.contentViewBoundsWidth * 4 / 12)  {
                scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
            } else if scrollView.contentOffset.x > (parallaxView.contentViewBoundsWidth * 4 / 12) {
                scrollView.setContentOffset(CGPoint(x: ((parallaxView.contentViewBoundsWidth / 3) * 2), y: 0), animated: true)
            }
        } else if parallaxView.page == 3 {
            if scrollView.contentOffset.x < (parallaxView.contentViewBoundsWidth * 8 / 12) {
                scrollView.setContentOffset(CGPoint(x: (parallaxView.contentViewBoundsWidth / 3), y: 0), animated: true)
            }
        } else {
            print("\(parallaxView.page) is not working")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == parallaxView.contentScrollView {
            let percentageOffset: CGFloat = parallaxView.contentScrollView.contentOffset.x / parallaxView.maxContentOffset
            let currentBackgroundOffsetPoint: CGPoint = CGPoint(x: ((parallaxView.maxBackgroundOffset * percentageOffset) + 50),y: 0)
            parallaxView.backgroundScrollView.setContentOffset(currentBackgroundOffsetPoint, animated: false)
        }
        if parallaxView.contentScrollView.contentOffset.x == 0 {
            parallaxView.page = 1
        } else if parallaxView.contentScrollView.contentOffset.x == view.bounds.width {
            parallaxView.page = 2
        } else if parallaxView.contentScrollView.contentOffset.x == view.bounds.width * 2 {
            parallaxView.page = 3
        }
    }
    

}

