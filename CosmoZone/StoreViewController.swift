//
//  StoreViewController.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-05-10.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var storeItems:[StoreItem] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self

        storeItems = createStoreItems()
        setupStoreScrollView(storeItems: storeItems)

        pageControl.numberOfPages = storeItems.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    func createStoreItems() -> [StoreItem] {
        let storeItem1:StoreItem = Bundle.main.loadNibNamed("StoreItem", owner: self, options: nil)?.first as! StoreItem
        storeItem1.imageView.image = UIImage(named: "spaceship")
        storeItem1.nameLabel.text = "Super Jet 5000"
        storeItem1.priceLabel.text = "$300"

        let storeItem2:StoreItem = Bundle.main.loadNibNamed("StoreItem", owner: self, options: nil)?.first as! StoreItem
        storeItem2.imageView.image = UIImage(named: "spaceship")
        storeItem2.nameLabel.text = "Spaceship Ultra"
        storeItem2.priceLabel.text = "$500"

        let storeItem3:StoreItem = Bundle.main.loadNibNamed("StoreItem", owner: self, options: nil)?.first as! StoreItem
        storeItem3.imageView.image = UIImage(named: "spaceship")
        storeItem3.nameLabel.text = "Spaceship Jetta 9000"
        storeItem3.priceLabel.text = "$1000"

        let storeItem4:StoreItem = Bundle.main.loadNibNamed("StoreItem", owner: self, options: nil)?.first as! StoreItem
        storeItem4.imageView.image = UIImage(named: "spaceship")
        storeItem4.nameLabel.text = "Spaceship Camry"
        storeItem4.priceLabel.text = "$1500"

        let storeItem5:StoreItem = Bundle.main.loadNibNamed("StoreItem", owner: self, options: nil)?.first as! StoreItem
        storeItem5.imageView.image = UIImage(named: "spaceship")
        storeItem5.nameLabel.text = "Spaceship Urus"
        storeItem5.priceLabel.text = "$5000"

        return [storeItem1, storeItem2, storeItem3, storeItem4, storeItem5]
    }

    func setupStoreScrollView(storeItems : [StoreItem]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(storeItems.count), height: 1.0)
        scrollView.isPagingEnabled = true

        for i in 0 ..< storeItems.count {
            storeItems[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(storeItems[i])
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)

        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)

        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {

            storeItems[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            storeItems[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)

        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            storeItems[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            storeItems[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)

        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            storeItems[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            storeItems[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)

        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            storeItems[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            storeItems[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
}
