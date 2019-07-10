//
//  tempViewController.swift
//  test2
//
//  Created by miaoz on 2019/2/14.
//  Copyright © 2019 miaoz. All rights reserved.
//

import UIKit
import Speech
import SwiftyJSON
import AVFoundation
class speeh_text_ViewController: UIViewController,SFSpeechRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate,choice_delgate{
    struct trandate {
        var before_text:String
        var after_text:String
        var type:String
    }
    
    @IBOutlet weak var voice_text: UITextView!
    @IBOutlet weak var choice_lau: UIButton!
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var L2: UILabel!
    @IBOutlet weak var L1: UILabel!
    @IBOutlet weak var Waveright: NSLayoutConstraint!
    @IBOutlet weak var Waveleft: NSLayoutConstraint!
    var tar:String="中文"{
        didSet{
            DispatchQueue.main.async {
                self.L2.text = NSLocalizedString(self.tar, comment: "tran")
            }
        }
    }
    var souce:String="英语"{
        didSet{
            DispatchQueue.main.async {
              self.L1.text = NSLocalizedString(self.souce, comment: "tran")
            }
        }
    }
    var Switchertext:String = "error"
    let googleAPIKey = "24.2833b59e4d900c5294bf4eb2d50996c2.2592000.1551505229.282335-15513376"
    let appid="20190201000261846"
    let baidukey="_dTto8Nhuzcy1wq9gzHi"
    let lau_date:[String:String]=Lautype_Apikey_date().Lau_date
    let speech_lau_date:[String:String]=Lautype_Apikey_date().ios_Speech_laudate()
    var trandatedict:[trandate]=[]{
        didSet{
            DispatchQueue.main.async {
                self.tabelview.reloadData()
            }
        }
    }
   var speechRecognizer=SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    
    //@IBOutlet weak var Language2Voice: UIButton!
  //  @IBOutlet weak var Language1Voice: UIButton!

    @IBOutlet weak var RedCon: UIButton!

    @IBOutlet weak var Switcher: UIButton!
    @IBAction func SwitcherAction(_ sender: Any) {
        UIView.animate(withDuration: 0.2){
            self.Switcher.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
            
        }
        self.Switcher.transform = CGAffineTransform.identity
        Switchertext = tar
        tar = souce
        souce = Switchertext
        L2.text = self.souce
        L1.text = self.tar
        
    }
    

    @IBAction func BackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var tabelview: UITableView!
    @IBOutlet weak var microphoneButton2: UIButton!
//  waveformView
    @IBOutlet weak var waveformView: SCSiriWaveformView!
    
    var aacPath:String?
    
    
    
    
    
    let synth = AVSpeechSynthesizer() //TTS对象
    let audioSession = AVAudioSession.sharedInstance() //语音引擎
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    var recorder:AVAudioRecorder?
    
    
    
    func loaclized(){
        DispatchQueue.main.async {
           self.L1.text = NSLocalizedString(self.souce, comment: "tran")
            self.L2.text = NSLocalizedString(self.tar, comment: "tran")
            self.back_btn.setTitle(NSLocalizedString("返回", comment: "back1") , for: .normal)
            self.choice_lau.setTitle(NSLocalizedString("选择语言", comment: "选择语言") , for: .normal)
             self.voice_text.text=NSLocalizedString("按下按钮开始录音", comment: "按下按钮开始录音") 
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 //wuruofeng
        loaclized()
        waveformView.layer.cornerRadius = 16
        waveformView.transform = CGAffineTransform.init(scaleX: 1, y: 0.0)
        waveformView.alpha = 0.2
        microphoneButton.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0)
        microphoneButton2.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0)
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.1")
            
        }
        
        
        
        let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0) as Float),//声音采样率
            AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC) as Int32),//编码格式
            AVNumberOfChannelsKey : NSNumber(value: 1 as Int32),//采集音轨
            AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue) as Int32)]//音频质量
        let settings = [AVSampleRateKey:44100.0,
            AVFormatIDKey:kAudioFormatAppleLossless,
            AVNumberOfChannelsKey:2,
            AVEncoderAudioQualityKey:0] as [String : Any]

        //let url = NSURL.init(fileURLWithPath: "/dev/null")
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                         .userDomainMask, true)[0]
        aacPath = docDir + "/play.aac"
        recorder = try! AVAudioRecorder(url: URL(string: "/dev/null")!,
                                        settings: settings)
        
        
    //self.recorder = try AVAudioRecorder.init(url: url as URL, settings: settings)
        let displaylink = CADisplayLink.init(target: self, selector: #selector(updateMeters))
        displaylink.add(to: .current, forMode: .common)
        self.waveformView.waveColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.waveformView.primaryWaveLineWidth = CGFloat(3.0)
        self.waveformView.secondaryWaveLineWidth = CGFloat(1.0)
        
        
//
        microphoneButton.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0)
        microphoneButton.layer.cornerRadius = 16
        microphoneButton2.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0)
        microphoneButton2.layer.cornerRadius = 16
        microphoneButton.setTitle(souce, for: UIControl.State.normal)
        microphoneButton2.setTitle(tar, for: UIControl.State.normal)
        
        Switcher.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.8, delay:2.0, animations:{self.Switcher.transform = CGAffineTransform.identity} )
        
        textview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textview.layer.cornerRadius = 16
        
        //
        self.tabelview.rowHeight=CGFloat(integerLiteral: 80)
        self.textview.isEditable=false
        synth.delegate = self
        self.tabelview.delegate=self
        self.tabelview.dataSource=self
        self.tabelview.allowsSelection=false
        microphoneButton.isEnabled=false
        microphoneButton2.isEnabled=false
        speechRecognizer?.delegate=self
        SFSpeechRecognizer.requestAuthorization{ (authStatus) in
            var isButtonEnabled = false
            
            switch authStatus { //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
                self.microphoneButton2.isEnabled = isButtonEnabled
            }
        }
        
    }
    @IBAction func to_choice_lau(_ sender: Any) {
        
    }
    @IBAction func before_play(_ sender: Any) {
        
        let btn=sender as!UIButton
        let cell=btn.superView(of: UITableViewCell.self)!
        // let textview:UITextView=cell.viewWithTag(212) as! UITextView
        let rrow = self.tabelview.indexPath(for: cell)?.row
        print(self.speech_lau_date[self.tar]!+"1")
        print(self.trandatedict[rrow!].after_text)
        self.speakText(voiceOutdata: self.trandatedict[rrow!].after_text, lautype: self.speech_lau_date[self.tar]!)
        
    }
    
    @IBAction func after_paly(_ sender: Any) {
        
        let btn=sender as!UIButton
        let cell=btn.superView(of: UITableViewCell.self) as!UITableViewCell
        print(1)
        let rrow = self.tabelview.indexPath(for: cell)?.row
        print(self.speech_lau_date[self.souce])
        //let textview:UITextView=cell.viewWithTag(222) as! UITextView
        print(self.trandatedict[rrow!].after_text)
        self.speakText(voiceOutdata: self.trandatedict[rrow!].after_text, lautype: self.speech_lau_date[self.souce]!)
        
    }
    
    @IBAction func mic1tapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
//rf留言:这里顺序别乱换 老子花了三个钟头调试这个bug
            self.recorder!.stop()
            recognitionRequest?.endAudio()
            translate(text: self.textview.text, type: "before")
           // self.trandatedict.append(trandate(before_text: self.textview.text, after_text: "", type: "before"))
          // self.tabelview.reloadData()
            microphoneButton.isEnabled = false
             microphoneButton2.isEnabled = true
            
            L1.text = self.souce
            microphoneButton.setImage(UIImage.init(named: "VoiceRed"), for: UIControl.State.normal)
//            waveformView.isHidden = true
            UIView.animate(withDuration: 0.5) {
                self.waveformView.transform = CGAffineTransform.init(scaleX: 1, y: 0)
                self.waveformView.alpha = 0.2
            }
            microphoneButton2.isHidden = false
            Switcher.isHidden = false
            L2.isHidden = false
             textview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            textview.text = "按下按钮开始录音"
        } else {
            self.recorder!.prepareToRecord()
            self.recorder!.isMeteringEnabled = true
            self.recorder!.record()
            speechRecognizer=SFSpeechRecognizer(locale: Locale.init(identifier: self.speech_lau_date[self.souce]!))
            microphoneButton2.isEnabled = false
            startRecording()
            L1.text = "录音中"
//
        microphoneButton.setImage(UIImage.init(named: "VoiceRedStop"), for: UIControl.State.normal)
            waveformView.backgroundColor = #colorLiteral(red: 0.9543243051, green: 0.4074439406, blue: 0.4107380509, alpha: 1)
             textview.backgroundColor = #colorLiteral(red: 0.9543243051, green: 0.5750493481, blue: 0.5557762316, alpha: 1)
            Waveleft.constant = 50
            Waveright.constant = 0
                waveformView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.waveformView.transform = CGAffineTransform.identity
                self.waveformView.alpha = 1
            }
            Switcher.isHidden = true
            L2.isHidden = true
                microphoneButton2.isHidden = true
            
        }
    }
    @IBAction func mic2tapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            self.recorder!.stop()
            recognitionRequest?.endAudio()
            translate(text: self.textview.text, type: "after")
            //self.trandatedict.append(trandate(before_text: self.textview.text, after_text: "", type: "after"))
          //  self.tabelview.reloadData()
            microphoneButton2.isEnabled = false
            microphoneButton.isEnabled = true
            L2.text = self.tar
            microphoneButton2.setImage(UIImage.init(named: "VoiceBlue"), for: UIControl.State.normal)
            waveformView.isHidden = true
            microphoneButton.isHidden = false
            Switcher.isHidden = false
            L1.isHidden = false
           textview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           textview.text = "按下按钮开始录音"
            UIView.animate(withDuration: 0.5) {
                self.waveformView.transform = CGAffineTransform.init(scaleX: 1, y: 0)
                self.waveformView.alpha = 0.2
                
            }

        } else {
            self.recorder!.prepareToRecord()
            self.recorder!.isMeteringEnabled = true
            self.recorder!.record()
          speechRecognizer=SFSpeechRecognizer(locale: Locale.init(identifier: self.speech_lau_date[self.tar]!))
            microphoneButton.isEnabled = false
            startRecording()
            L2.text = "录音中"
//
            microphoneButton2.setImage(UIImage.init(named: "VoiceBlueStop"), for: UIControl.State.normal)
             textview.backgroundColor = #colorLiteral(red: 0.6111473671, green: 0.7817914896, blue: 0.9688740373, alpha: 1)
            waveformView.backgroundColor = #colorLiteral(red: 0.4133239388, green: 0.6501145959, blue: 0.9765883088, alpha: 1)
            Waveleft.constant = 0
            Waveright.constant = 50
            waveformView.isHidden = false
            Switcher.isHidden = true
            UIView.animate(withDuration: 0.4) {
                self.waveformView.transform = CGAffineTransform.identity
                self.waveformView.alpha = 1
            }
            microphoneButton.isHidden = true
            
        }
    }
    
    @objc func updateMeters(){
        var normalizedValue:CGFloat
        self.recorder! .updateMeters()
        normalizedValue = self._normalizedPowerLevelFromDecibels(decibels: CGFloat(self.recorder!.averagePower(forChannel: 0)))
        
        self.waveformView .update(withLevel: normalizedValue)
        
        
    }
    
    
    

    
    func _normalizedPowerLevelFromDecibels(decibels:CGFloat) ->CGFloat{
        if (decibels < CGFloat(-60.0) || decibels == CGFloat(0.0)) {
            return CGFloat(0.0)
        }
        else{
            let lhs = (pow(CGFloat(10.0), CGFloat(0.05)*decibels)-pow(CGFloat(10.0), CGFloat(0.05)*CGFloat(-60.0))) * (CGFloat(1.0) / (CGFloat(1.0)-pow(CGFloat(10.0),CGFloat(0.05)*CGFloat(-60.0))))
            let rhs = CGFloat(1.0) / CGFloat(2.0)
            return pow(lhs, rhs)
        }
    }
    
    
    
}


