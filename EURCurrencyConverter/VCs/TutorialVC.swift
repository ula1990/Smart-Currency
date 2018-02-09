//
//  TutorialVC.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-02-02.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {
    
    @IBOutlet weak var firstText: UILabel!
    @IBOutlet weak var secondText: UILabel!
    @IBOutlet weak var thirdText: UILabel!
    @IBOutlet weak var fourthText: UILabel!
    @IBOutlet weak var fifthText: UILabel!
    @IBOutlet weak var sixthText: UILabel!
    
    @IBOutlet weak var firstLabel: DiffLabel!
    @IBOutlet weak var secondLabel: DiffLabel!
    @IBOutlet weak var thirdLabel: UIImageView!
    @IBOutlet weak var fourthLabel: DiffLabel!
    @IBOutlet weak var fifthLabel: UIImageView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.firstText.alpha = 0
        self.firstLabel.alpha = 0
        self.secondText.alpha = 0
        self.secondLabel.alpha = 0
        self.thirdText.alpha = 0
        self.thirdLabel.alpha = 0
        self.fourthText.alpha = 0
        self.fourthLabel.alpha = 0
        self.fifthText.alpha = 0
        self.fifthLabel.alpha = 0
        self.sixthText.alpha = 0

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.firstText.alpha = 1
        }, completion: {(true) in
            UIView.animate(withDuration: 0.3, animations: {
                self.firstLabel.alpha = 1
            }, completion: {(true) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.secondText.alpha = 1
                }, completion: {(true) in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.secondLabel.alpha = 1
                    }, completion: {(true) in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.thirdText.alpha = 1
                        }, completion: {(true) in
                            UIView.animate(withDuration: 0.3, animations: {
                                self.thirdLabel.alpha = 1
                            }, completion: {(true) in
                                UIView.animate(withDuration: 0.3, animations: {
                                    self.fourthText.alpha = 1
                                }, completion: {(true) in
                                    UIView.animate(withDuration: 0.3, animations: {
                                        self.fourthLabel.alpha = 1
                                    }, completion: {(true) in
                                        UIView.animate(withDuration: 0.3, animations: {
                                            self.fifthText.alpha = 1
                                        }, completion: {(true) in
                                            UIView.animate(withDuration: 0.3, animations: {
                                                self.fifthLabel.alpha = 1
                                            }, completion: {(true) in
                                                UIView.animate(withDuration: 0.3, animations: {
                                                    self.sixthText.alpha = 1
                                                }, completion: {(true) in
                                                    
                                                })
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
    }


}
