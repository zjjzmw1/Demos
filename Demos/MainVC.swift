//
//  MainVC.swift
//  Demos
//
//  Created by 田子瑶 on 16/9/27.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit
import AudioToolbox


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var demos: [MainModel] = []
    var tableView: UITableView!
    var collectionView: UICollectionView!
    var headView: MainHeadView!
    
    let idenContentString = "idenContentString"
    let headIdenString = "headIdenString"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataSource()
        installUI()
        
    }
    
    func installUI() {
        
        let topView = MainTopView(frame: CGRect(x: 0, y: 0, width: Custom.SCREENWIDTH(), height: 20))
        let bottomLabel = MainBottomLabel(frame: CGRect(x: 0, y: Custom.SCREENHEIGHT() - 40, width: Custom.SCREENWIDTH(), height: 30))
        let topLabel = MainTopLabel(frame: CGRect(x: 0, y: 120, width: Custom.SCREENWIDTH(), height: 30))
        let blurView = MainBlurView(frame: self.view.bounds)
        
        headView = MainHeadView(frame: CGRect(x: 0, y: 20, width: Custom.SCREENWIDTH(), height: 80))
        headView.listDisplayBtn.addTarget(self, action: #selector(MainVC.showList), for: .touchUpInside)
        headView.cardDisplayBtn.addTarget(self, action: #selector(MainVC.showCard), for: .touchUpInside)
        
        self.view.addSubview(bottomLabel)
        self.view.addSubview(topLabel)
        self.view.backgroundColor = Custom.LPCRGBA(r: 5, g: 41, b: 36, a: 1)
        self.view.addSubview(topView)
        self.view.addSubview(headView)
        
        
        installTableView()
        installCollectionView()
        
        self.view.addSubview(blurView)

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runDemo(withName name: String)  {
        switch name {
            
        case "自定义字体和切换字体":
            let customFontSB = UIStoryboard(name: "CustomFont", bundle: nil)
            let customFontVC = customFontSB.instantiateViewController(withIdentifier: "CustomFontVC")
            self.present(customFontVC, animated: true, completion: nil)
            
        case "获取公众号粉丝的头像":
            let wechatFansSB = UIStoryboard(name: "WeChatFansHeadImg", bundle: nil)
            let wechatFansVC = wechatFansSB.instantiateViewController(withIdentifier: "WeChatFansHeadImgVC")
            self.present(wechatFansVC, animated: true, completion: nil)
            
        case "抓取维基词条图片":
            let wikiVC = WiKiPictureVC()
            self.present(wikiVC, animated: true, completion: nil)
            
        case "定位现在的位置":
            let whereSB = UIStoryboard(name: "Where", bundle: nil)
            let WhereVC = whereSB.instantiateViewController(withIdentifier: "WhereVC")
            self.present(WhereVC, animated: true, completion: nil)
            
        case "播放本地视频":
            let PlayLocalVideoSB = UIStoryboard(name: "PlayLocalVideo", bundle: nil)
            let PlayLocalVideoVC = PlayLocalVideoSB.instantiateViewController(withIdentifier: "PlayLocalVideoVC")
            self.present(PlayLocalVideoVC, animated: true, completion: nil)
            
        case "播放本地视频":
            let PlayLocalVideoSB = UIStoryboard(name: "PlayLocalVideo", bundle: nil)
            let PlayLocalVideoVC = PlayLocalVideoSB.instantiateViewController(withIdentifier: "PlayLocalVideoVC")
            self.present(PlayLocalVideoVC, animated: true, completion: nil)
            
        case "播放本地视频":
            let PlayLocalVideoSB = UIStoryboard(name: "PlayLocalVideo", bundle: nil)
            let PlayLocalVideoVC = PlayLocalVideoSB.instantiateViewController(withIdentifier: "PlayLocalVideoVC")
            self.present(PlayLocalVideoVC, animated: true, completion: nil)
            
        case "下拉刷新":
            let pullToRefreshVC = PullToRefreshVC()
            self.present(pullToRefreshVC, animated: true, completion: nil)
            
        case "播放音乐及颜色渐变":
            let str = "RandomColor"
            presentVC(vcName: str)
            
        case "视频作为背景的登录页":
            let str = "VideoBackground"
            presentVC(vcName: str)
            
        case "走马灯式的卡片浏览":
            let str = "CarouselEffect"
            presentVC(vcName: str)
            
        case "图片浏览效果":
            let str = "ImageScrollerEffect"
            presentVC(vcName: str)
            
        case "具有动画校验的登录页":
            let str = "Splas"
            presentVC(vcName: str)
            
        case "动画效果表单":
            let str = "animateTable"
            presentVC(vcName: str)
            
        case "抽奖老虎机":
            let str = "EmojiMachine"
            presentVC(vcName: str)
            
        case "点赞按钮特效":
            let favoriteVC = FavoriteButton()
            self.present(favoriteVC, animated: true, completion: nil)
            
            

        default:
            print("没有 \(name) 这个Demo")
        }
    }
    
    func presentVC(vcName: String) {
        let sb = UIStoryboard(name: vcName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcName + "VC")
        self.present(vc, animated: true, completion: nil)
    }
    
    func showList() {

        tableView.isHidden = false
        collectionView.isHidden = true
        headView.listDisplayBtn.isEnabled = false
        headView.cardDisplayBtn.isEnabled = true
    }
    
    func showCard() {
        
        tableView.isHidden = true
        collectionView.isHidden = false
        headView.cardDisplayBtn.isEnabled = false
        headView.listDisplayBtn.isEnabled = true
    }
    
    func installTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: Custom.SCREENWIDTH(), height: Custom.SCREENHEIGHT() - 100))
        //tableView.bounds.origin.y = tableView.bounds.origin.y - 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(MainCell.self, forCellReuseIdentifier: "ClearCell")
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        
        tableView!.addGestureRecognizer(tableViewlongPressTag())
        
        headView.listDisplayBtn.isEnabled = false
    }
    
    func installCollectionView() {
        
        self.automaticallyAdjustsScrollViewInsets = true
        //  设置 layOut
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical  //滚动方向
        layout.itemSize = CGSize(width: (Custom.SCREENWIDTH() - 60)/2, height: 100)
        // 设置CollectionView
        let frame = CGRect(x: 0, y: 105, width: Custom.SCREENWIDTH(), height: Custom.SCREENHEIGHT() - 105)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Custom.LPCRGBA(r: 14, g: 42, b: 72, a: 1)
        collectionView .register(CardCell.self, forCellWithReuseIdentifier: idenContentString)
        self.view .addSubview(collectionView)
        collectionView.isHidden = true
        
        collectionView!.addGestureRecognizer(collectionViewlongPressTag())

    }
    
    /**
     collectionView的delegate和dataSource
     */
    
    func collectionViewlongPressTag() -> UILongPressGestureRecognizer {
        
        let longPress =  UILongPressGestureRecognizer(target: self,
                                                      action: #selector(MainVC.collectionViewLongPressed(gestureRecognizer:)))
        longPress.delegate = self
        longPress.minimumPressDuration = 1.0
        return longPress
    }

    func collectionViewLongPressed(gestureRecognizer:UILongPressGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: collectionView)

        switch gestureRecognizer.state {
        case .began:
            //判断长按位置是否在路径上
            let indexPath = self.collectionView.indexPathForItem(at: touchPoint)
            if indexPath == nil {
                break
            }
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            //开始移动该位置的cell
            collectionView.beginInteractiveMovementForItem(at: indexPath!)
            break
        case .changed:
            //移动过程中更新cell的位置
            collectionView.updateInteractiveMovementTargetPosition(touchPoint)
            break
        case .ended:
            collectionView.endInteractiveMovement()
            break
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }
    
    //MARK: 允许collectionCell移动
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK: 移动collectionCell
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath != destinationIndexPath{
            //获取移动行对应的值
            let demo = demos[sourceIndexPath.row]
            //删除移动的值
            demos.remove(at: sourceIndexPath.row)
            //如果移动区域大于现有行数，直接在最后添加移动的值
            if destinationIndexPath.row > demos.count{
                demos.append(demo)
            }else{
                //没有超过最大行数，则在目标位置添加刚才删除的值
                demos.insert(demo, at:destinationIndexPath.row)
            }
        }
        
    }
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return demos.count
    }
    
    func  collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: idenContentString, for: indexPath) as! CardCell
        cell.myLabel.text = demos[indexPath.row].name
        cell.myImageView.image = UIImage(named: demos[indexPath.row].icon!)
        return cell;
    }
    
    //MARK: 点击collectionCell的事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        
        runDemo(withName: cell.myLabel.text!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 20, 10, 20)
    }
    
    /**
     tableView的delegate和dataSource
     */
    
    //MARK: 点击tableCell的事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        runDemo(withName: (cell?.textLabel?.text)!)
        
    }
    
    func tableviewCellLongPressed(gestureRecognizer:UILongPressGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizerState.began) {
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)

            if (tableView!.isEditing == false) {
                tableView!.setEditing(true, animated:true)

            }
            else{
                tableView!.setEditing(false, animated:true)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        
        if fromIndexPath != toIndexPath{
            //获取移动行对应的值
            let demo = demos[fromIndexPath.row]
            //删除移动的值
            demos.remove(at: fromIndexPath.row)
            //如果移动区域大于现有行数，直接在最后添加移动的值
            if toIndexPath.row > demos.count{
                demos.append(demo)
            }else{
                //没有超过最大行数，则在目标位置添加刚才删除的值
                demos.insert(demo, at:toIndexPath.row)
            }
        }
        tableView.setEditing(false, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClearCell", for: indexPath)
        cell.textLabel?.text = demos[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor =  colorforIndex(index: indexPath.row)
        
    }
    
    /**
     计算cell的颜色
     */
    func colorforIndex(index: Int) -> UIColor {
        
        let itemCount = demos.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }
    
    /**
     添加tableView的长按响应
     */
    func tableViewlongPressTag() -> UILongPressGestureRecognizer {
        
        let longPress =  UILongPressGestureRecognizer(target: self,
                                                      action: #selector(MainVC.tableviewCellLongPressed(gestureRecognizer:)))
        longPress.delegate = self
        longPress.minimumPressDuration = 1.0
        return longPress
    }
    
    /**
     plist文件转模型类
     */
    func getDataSource() {
        
        if let dataPath = Bundle.main.path(forResource: "DemoList", ofType: "plist") {
            let datas = NSArray.init(contentsOfFile: dataPath)
            for data in datas! {
                let demo = MainModel()
                demo.setValuesForKeys(data as! [String : Any])
                demos.append(demo)
            }
        }
    }
    
}
