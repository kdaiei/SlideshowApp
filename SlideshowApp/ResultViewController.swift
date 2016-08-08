//
//  ResultViewController.swift
//  SlideshowApp
//
//  Created by kobayashi on 2016/08/06.
//  Copyright © 2016年 hirotaka.kobayashi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    // イメージのファイル名
    var imageName:String = ""
    
    // イメージビュー
    @IBOutlet weak var resultImageView: UIImageView!
    // 戻るボタン
    @IBOutlet weak var returnButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // イメージビュー初期化
        initImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    // イメージビューを初期化する
    func initImageView() {
        // 縦横の比率をそのままに短い辺を基準に全体表示
        resultImageView.contentMode = UIViewContentMode.ScaleAspectFill
        // イメージ表示
        setImage(imageName)
    }
    
    // イメージをセット
    func setImage(imageName :String) {
        let image:UIImage? = UIImage(named: imageName)
        
        resultImageView.image = image
    }

}
