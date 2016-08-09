//
//  ViewController.swift
//  SlideshowApp
//
//  Created by kobayashi on 2016/08/05.
//  Copyright © 2016年 hirotaka.kobayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imageMax = 3            // イメージの最大数
    var index = 0;              // インデックス
    var timer: NSTimer?         // タイマー
    let tagImageView = 1        // イメージビュータグ（イメージビューにタッチイベントを追加するため）
    var playFlag:Bool = false   // 再生中フラグ
    var imageList:[String] = [] // イメージリスト
    
    // イメージビュー
    @IBOutlet var imageView: UIImageView!
    
    // 次へボタンをタップ
    @IBAction func nextBtn(sender: AnyObject) {
        index = nextImg(index, max: imageMax)
        setImage(index)
    }
    
    // 戻るボタンをタップ
    @IBAction func preBtn(sender: AnyObject) {
        index = preImg(index, max: imageMax)
        setImage(index)
    }
    
    // 次へボタン
    @IBOutlet weak var nextBottom: UIButton!
    // 戻るボタン
    @IBOutlet weak var preBottom: UIButton!
    // 再生ボタン
    @IBOutlet var playBtm: UIButton!
    
    // 再生ボタンをタップ
    @IBAction func startBtn(sender: AnyObject) {
        if "再生" == playBtm.titleLabel?.text! {
            startTimer()
            playBtm.setTitle("停止", forState: .Normal)
            nextBottom.enabled = false
            preBottom.enabled = false
            playFlag = true
        } else {
            stopTimer()
            playBtm.setTitle("再生", forState: .Normal)
            nextBottom.enabled = true
            preBottom.enabled = true
            playFlag = false
        }
    }

    // イメージファイルの一覧を取得
    func getImageList() {
        let manager = NSFileManager.defaultManager()
        
        let path = NSBundle.mainBundle().resourcePath
        do {
            let list = try manager.contentsOfDirectoryAtPath(path!)
            for filename in list {
                if filename.hasSuffix("jpeg") {
                    imageList.append(filename)
                }
            }
            imageMax = imageList.count
        } catch  {
            print("fileList err")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getImageList()  // ファイルリスト取得
        initImageView() // イメージビュー初期化
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // イメージ表示
    func setImage(num :Int) {
        let image:UIImage? = UIImage(named: imageList[num])
        imageView.image = image
    }
    
    // 次のインデックスをセット
    func nextImg(ind: Int , max: Int) -> Int {
        var index = ind
        if index + 1 > max - 1 {
            index = 0
        } else {
            index = index + 1
        }
        return index
    }
    
    // 戻るインデックスをセット
    func preImg(ind: Int , max: Int) -> Int {
        var index = ind
        if index - 1 < 0 {
            index = max - 1
        } else {
            index = index - 1
        }
        return index
    }

    // イメージビューを表示
    func initImageView() {
        imageView.userInteractionEnabled = true
        imageView.tag = tagImageView
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        setImage(index)
    
    }

    // スライドショー用のタイマースタート
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(update(_:)), userInfo: nil, repeats: true)
    }

    // スライドショー用タイマー更新
    @objc func update(timer: NSTimer) {
        index = nextImg(index, max: imageMax)
        setImage(index)
    }
    
    // スライドショー用タイマー停止
    func stopTimer() {
        timer?.invalidate()
    }
    
    // 拡大画面表示に画面遷移
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destinationViewController as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているx, yに値を代入して渡す
        resultViewController.imageName = imageList[index]
    }
    
    // イメージビューにタッチイベントを追加
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            if tag == tagImageView {
                stopTimer()
                performSegueWithIdentifier("toResultViewController",sender: nil)
            }
        }
    }
    
    // 戻る処理
    @IBAction func unwind(segue: UIStoryboardSegue) {
        if true == playFlag {
            startTimer()
        }
    }

}

