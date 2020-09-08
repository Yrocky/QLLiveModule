//
//  DemoResumeModule.swift
//  Example-swift
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

import QLLiveModuler

class DemoResumeModule: QLLiveModule {

    override func refresh() {
        super.refresh()
        do {
            let path = Bundle.main.path(forResource: "Resume", ofType: "json")!
            let jsonData = try JSONSerialization.jsonObject(
                with: NSData(contentsOfFile: path) as Data,
                options: .allowFragments
            )
            setupComponent(jsonData as! [String : Any])
        } catch  {
            print("JSONSerialization error \(error)")
        }
        collectionView.reloadData()
    }
    
    func setupComponent(_ jsonData: [String: Any]) {
        
        let imageComp = ResumeImageComponent()
        imageComp.add(data:"aaa")
        
        let basicInfoComp = ResumeBasicInfoComponent()
        basicInfoComp.add(
            datas:jsonData["basic"] as! Array<[String : Any]>
        )
        
        let skillComp = ResumeSkillComponent()
        skillComp.add(
            datas: jsonData["skill"] as! Array<String>
        )
        
        let companyComp = ResumeCompanyComponent()
        companyComp.add(
            datas: jsonData["company"] as! Array<String>
        )
        
        dataSource.add([
            imageComp,basicInfoComp,skillComp,
            companyComp
        ])
    }
}
