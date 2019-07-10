import UIKit
protocol choice_delgate {
    func clikedvalue(souce: String, tar: String)
}
class Language1VC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var Onehand: NSLayoutConstraint!
    @IBOutlet weak var segmented_control: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    var delegate:choice_delgate?
    var souce:String!
    var tar:String!
    var touch:String!
    let lau_date=["英语":"en","中文":"zh","俄语":"de"]
    let lau_viewdate:[String]=Lautype_Apikey_date.Lau_type_date
    @IBAction func BackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var LanguageSelecter: UISegmentedControl!
    @IBOutlet weak var SearchBtn: UIButton!
    @IBOutlet weak var SearchBar: UITextField!
    
    @IBOutlet weak var Onehand4: NSLayoutConstraint!
    @IBOutlet weak var Onehan3: NSLayoutConstraint!
    @IBOutlet weak var Onehand2: NSLayoutConstraint!
    @IBAction func choice_lau_changed(_ sender: Any) {
        if self.touch=="tar"
        {
            self.touch="souce"
        }
        else{
            self.touch="tar"
        }
    }
    @IBAction func cell_touch(_ sender: Any) {
        let btn=sender as!UIButton
        let cell=btn.superView(of: UITableViewCell.self)!
        let label=cell.viewWithTag(100)as! UILabel
        if self.touch=="tar"
        {
            self.tar=label.text
            print(label.text)
        }
        else{
            self.souce=label.text
            print(label.text)
        }
        delegate?.clikedvalue(souce: self.souce, tar: self.tar)
        self.dismiss(animated: true, completion: nil)
    }
    func loaclized(){
        DispatchQueue.main.async {
            self.SearchBtn.setTitle(NSLocalizedString("搜索", comment: "搜索"), for: .normal)
            self.segmented_control.setTitle(NSLocalizedString("源语言", comment: "源语言"), forSegmentAt: 0)
             self.segmented_control.setTitle(NSLocalizedString("译向语言", comment: "译向语言"), forSegmentAt: 1)
            self.titlelabel.text=NSLocalizedString("选择语言", comment: "选择语言")
            self.back_btn.setTitle(NSLocalizedString("返回", comment: "返回"), for: .normal)
            // self.bartitle.title = NSLocalizedString("翻译与工具", comment: "翻译与工具")
        }
        
    }
    override func viewDidLoad() {
        loaclized()
        super.viewDidLoad()
        Onehand.constant = OnehandMode.OnehandMode()
        Onehand2.constant = OnehandMode.OnehandMode()-30
        Onehan3.constant = OnehandMode.OnehandMode()-32
        Onehand4.constant = OnehandMode.OnehandMode()+4
        
        LanguageSelecter.tintColor =  UIColor.brown
        LanguageSelecter.layer.cornerRadius = 16
        SearchBar.layer.cornerRadius = 16
            SearchBtn.layer.cornerRadius = 16
            SearchBtn.backgroundColor = UIColor.brown
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(Language1VC.handleTap(sender:))))
        if self.touch == "tar"{
            self.segmented_control.selectedSegmentIndex=1
        }
        self.tableview.delegate=self
        self.tableview.dataSource=self
        self.tableview.allowsSelection=false
        // Do any additional setup after loading the view.
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended
        {
            SearchBar.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
