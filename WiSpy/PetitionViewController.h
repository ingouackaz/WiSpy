//
//  PetitionViewController.h
//  WiSpy
//
//  Created by Roger Ingouacka on 2014-03-01.
//
//

#import <UIKit/UIKit.h>

@interface PetitionViewController : UIViewController <UITextFieldDelegate,UIInputViewAudioFeedback>
{
    UITapGestureRecognizer *tapTwice;
    UITapGestureRecognizer *tapOnce;
}
@property (assign, nonatomic)  NSInteger hiddenMode;
@property (assign, nonatomic)  NSInteger petitionIndex;
@property (assign, nonatomic)  NSInteger arrayIndex;

@property (assign, nonatomic)  BOOL characterDelete;
@property (strong, nonatomic)  NSUserDefaults *defaults;

@property (strong, nonatomic)  NSString *petition;
@property (strong, nonatomic)  NSString *answer;
@property (strong, nonatomic)  NSArray *labelList;
@property (strong, nonatomic)  NSMutableArray *labelTextList;
@property (weak, nonatomic) IBOutlet UILabel *dotLabel;

@property (weak, nonatomic) IBOutlet UILabel *wiSpyAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *wiSpyReceivingDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *wiSpySendingData;
@property (weak, nonatomic) IBOutlet UILabel *wiSpyDataSended;
- (IBAction)newQuestionPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *petitionTextfield;
@property (weak, nonatomic) IBOutlet UITextField *questionTextfield;

@property (strong, nonatomic) IBOutlet UIButton *questionButton;
@property (strong, nonatomic) IBOutlet UIImageView *wiSpyLogoImageView;



@end
