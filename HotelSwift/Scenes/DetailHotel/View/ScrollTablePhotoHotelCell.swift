

import UIKit
import FSPagerView
import SnapKit

class ScrollTablePhotoHotelCell: BaseCell {
    let pagerView: FSPagerView = {
        let pager = FSPagerView()
        pager.automaticSlidingInterval =  3
        pager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pager.transformer = FSPagerViewTransformer(type: .cubic)
        return pager
    }()
    
    let pageControl = FSPageControl()
    
    private var images: [String] = []
    
    override func setupView() {
        self.selectionStyle = .none
        
        pagerView.dataSource = self
        pagerView.delegate = self
        
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        pageControl.frame = CGRect(x: 0, y: 100, width: self.contentView.frame.size.width, height: 30)
        
        contentView.addSubview(pagerView)
        pagerView.addSubview(pageControl)
        
        pagerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(250)
        }
        
        pageControl.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(-5)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
    }
    
    func setData(images: [String]) {
        self.images = images
        pagerView.reloadData()
    }
}

extension ScrollTablePhotoHotelCell: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        pageControl.numberOfPages = images.count
        return images.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let imageUrlString = images[index]
        cell.imageView?.loadImage(imageUrlString)
        return cell
    }
}

extension ScrollTablePhotoHotelCell: FSPagerViewDelegate {
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
}
