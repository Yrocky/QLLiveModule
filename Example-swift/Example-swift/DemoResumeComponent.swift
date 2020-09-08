//
//  DemoResumeComponent.swift
//  Example-swift
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

import QLLiveModuler

class DemoResumeComponent: QLLiveComponent {

}

class ResumeImageComponent: DemoResumeComponent {

    override init() {
        super.init()
        
        let layout = QLLiveListLayout()
        layout.distribution = .distribution(1)
        layout.itemRatio = .itemRatio(2.0)
        layout.arrange = .vertical
        self.setup(layout)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let ccell = dataSource?.dequeueReusableCell(
            of: ResumeImageCCell.self,
            for: self,
            at: index
        ) as! ResumeImageCCell
        
        return ccell
    }
}

class ResumeBasicInfoComponent: DemoResumeComponent {

    override init() {
        super.init()
        
        let layout = QLLiveListLayout()
        layout.distribution = .distribution(2)
        layout.itemRatio = .absolute(50)
        layout.inset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        self.setup(layout)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let ccell = dataSource?.dequeueReusableCell(
            of: ResumeBasicInfoCCell.self,
            for: self,
            at: index
        ) as! ResumeBasicInfoCCell
        ccell.setup(with: dataAt(index) as! [String : Any])
        return ccell
    }
}

class ResumeSkillComponent: DemoResumeComponent {

    override init() {
        super.init()
        let layout = QLLiveWaterfallLayout()
        layout.delegate = self
        layout.column = 1
        layout.renderDirection = .shortestFirst
        layout.inset = .init(top: 0, left: 5, bottom: 5, right: 5)

        self.setup(layout)
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let ccell = dataSource?.dequeueReusableCell(
            of: ResumeSkillCCell.self,
            for: self,
            at: index
        ) as! ResumeSkillCCell
        ccell.setup(with: dataAt(index) as! String)
        return ccell
    }
}

extension ResumeSkillComponent: QLLiveWaterfallLayoutDelegate {
    
    func layoutCustomItemSize(_ layout: QLLiveWaterfallLayout, at index: Int) -> CGSize {
        return .init(
            width: layout.itemWidth,
            height: CGFloat(
                ResumeSkillCCell.skillCellHeight(
                    with: dataAt(index) as! String)
            )
        )
    }
}


class ResumeCompanyComponent: DemoResumeComponent {
    
    override init() {
        super.init()
        let layout = QLLiveWaterfallLayout()
        layout.delegate = self
        layout.column = 1
        layout.renderDirection = .shortestFirst
        layout.inset = .init(top: 5, left: 5, bottom: 5, right: 5)
        self.setup(layout)
        
        self.addDecorate { (builder) in
            builder.decorate = .all
            builder.radius = 4.0
            builder.contents = .color(.textColor)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let ccell = dataSource?.dequeueReusableCell(
            of: ResumeCompanyCCell.self,
            for: self,
            at: index
        ) as! ResumeCompanyCCell
        ccell.setup(with: dataAt(index) as! [String: Any])
        return ccell
    }
    
    override func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    override func viewForSupplementaryElement(ofKind elementKind: String) -> UICollectionReusableView {
        if elementKind == UICollectionView.elementKindSectionHeader {
            let headerView = dataSource?.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                for: self,
                clazz: ResumeCompanyHeaderView.self
            ) as! ResumeCompanyHeaderView
            
            return headerView
        }
        return super.viewForSupplementaryElement(ofKind: elementKind)
    }
    
    override func sizeForSupplementaryView(ofKind elementKind: String) -> CGSize {
        if elementKind == UICollectionView.elementKindSectionHeader {
            return CGSize.init(width: 200, height: 40)
        }
        return .zero
    }
    
    override func insetForSupplementaryView(ofKind elementKind: String) -> UIEdgeInsets {
        if elementKind == UICollectionView.elementKindSectionHeader {
            return .init(top: 0, left: 5, bottom: 0, right: 5)
        }
        return .zero
    }
}

extension ResumeCompanyComponent: QLLiveWaterfallLayoutDelegate {
    
    func layoutCustomItemSize(_ layout: QLLiveWaterfallLayout, at index: Int) -> CGSize {
        return .init(width: layout.itemWidth, height: 100)
    }
}

class ResumeProjectComponent: DemoResumeComponent {

}
