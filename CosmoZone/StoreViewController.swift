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

    struct Item {
        var imageName: String
        var name: String
        var price: Int
    }

    var storeItems:[StoreItem] = []
    let spaceships: [Item] = [
        Item(imageName: "spaceship", name: "Super Jet 500", price: 300),
        Item(imageName: "spaceship", name: "SuperJet Ultra", price: 500),
        Item(imageName: "spaceship", name: "Jet Camry", price: 700),
        Item(imageName: "spaceship", name: "SuperPrado", price: 1000),
        Item(imageName: "spaceship", name: "Super Jet Urus", price: 5000)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self

        createStoreItems()
        setupStoreScrollView(storeItems: storeItems)

        pageControl.numberOfPages = storeItems.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    func createStoreItems(){
        for ship in spaceships {
            let item: StoreItem = Bundle.main.loadNibNamed("StoreItem", owner: self, options: nil)?.first as! StoreItem
            item.imageView.image = UIImage(named: ship.imageName)
            item.nameLabel.text = ship.name
            item.priceLabel.text = "$\(ship.price)"
            storeItems.append(item)
        }
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
            storeItems[0].storeItemStackView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            storeItems[1].storeItemStackView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            storeItems[1].storeItemStackView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            storeItems[2].storeItemStackView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            storeItems[2].storeItemStackView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            storeItems[3].storeItemStackView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            storeItems[3].storeItemStackView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            storeItems[4].storeItemStackView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
}
