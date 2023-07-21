//
//  ViewController.swift
//  HW #7 ScrollView
//
//  Created by Евгений Л on 21.07.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    enum Constants {
        static var imageHeight: CGFloat = 270
    }

    private let scrollView = UIScrollView()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ventura")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        configScroll()
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        imageView.frame = .init(x: 0, y: -scrollView.safeAreaInsets.top, width: scrollView.bounds.width, height: Constants.imageHeight)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
    }

    private func configScroll() {
        scrollView.delegate = self
        scrollView.indicatorStyle = .black
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y + scrollView.safeAreaInsets.top
        
        if offsetY < 0 {
            imageView.frame = .init(
                x: 0,
                y: -scrollView.safeAreaInsets.top + offsetY,
                width: scrollView.bounds.width,
                height: Constants.imageHeight + abs(offsetY)
            )
        }

        scrollView.verticalScrollIndicatorInsets.top = imageView.frame.height - scrollView.safeAreaInsets.top
    }
}


