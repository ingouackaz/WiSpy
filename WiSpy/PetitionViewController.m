//
//  PetitionViewController.m
//  WiSpy
//
//  Created by Roger Ingouacka on 2014-03-01.
//
//

#import "PetitionViewController.h"

@interface PetitionViewController ()

@end


@implementation PetitionViewController
@synthesize hiddenMode = _hiddenMode;
@synthesize petition = _petition;
@synthesize petitionIndex = _petitionIndex;
@synthesize characterDelete = _characterDelete;
@synthesize labelList = _labelList;
@synthesize labelTextList = _labelTextList;
@synthesize answer = _answer;
@synthesize questionButton = _questionButton;
@synthesize defaults = _defaults;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initPetitonData];

    

    [_petitionTextfield addTarget:self action:@selector(petitionTextfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _defaults = [NSUserDefaults standardUserDefaults];
    if ([_defaults objectForKey:@"alreadyOpen"] == nil) {
        [self performSegueWithIdentifier:@"Tutorial" sender:nil];
    }

}


-(void)initPetitonData
{
    _labelList = [[NSArray alloc] initWithObjects:_wiSpySendingData,_wiSpyDataSended,_wiSpyReceivingDataLabel,_dotLabel,_dotLabel,_wiSpyAnswerLabel, nil];
    _labelTextList = [[NSMutableArray alloc] initWithObjects:@">_Wi-Spy :   Sending data   ...",
                      @">_Wi-Spy :   Data send [SUCCESS]",
                      @">_Wi-Spy :   Receiving data ",@"...",@"...",
                      nil];
    
    
    tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapOnce:)];
    tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapTwice:)];
    
    
    [_wiSpyLogoImageView addGestureRecognizer:tapOnce];
    [_wiSpyLogoImageView addGestureRecognizer:tapTwice];
    tapOnce.numberOfTapsRequired = 1;
    tapTwice.numberOfTapsRequired = 2;
    
    [_wiSpyReceivingDataLabel setUserInteractionEnabled:NO];
    [_wiSpySendingData setUserInteractionEnabled:NO];
    
    [_wiSpyAnswerLabel setHidden:YES];
    [_wiSpyReceivingDataLabel setHidden:YES];
    [_wiSpyDataSended setHidden:YES];
    [_wiSpySendingData setHidden:YES];
    [_dotLabel setHidden:YES];
    _arrayIndex = 0;
    _hiddenMode = 0;
    _petition = @"Yes i support, Snowden";
    _answer = [[NSString alloc] init];
    _petitionIndex = 1;
    _characterDelete = NO;
    [_petitionTextfield setText:@""];
    [_questionTextfield setText:@""];
    [_petitionTextfield setEnabled:YES];
    [_questionTextfield setEnabled:YES];
    
}

- (IBAction)tapOnce:(id)sender {
    [tapOnce requireGestureRecognizerToFail:tapTwice];
    
}
- (IBAction)tapTwice:(id)sender {
    [self performSegueWithIdentifier:@"Tutorial" sender:nil];

}


-(void)petitionTextfieldChanged:(id)sender
{
    
    if (_hiddenMode == 0 && [_petitionTextfield.text characterAtIndex:_petitionTextfield.text.length-1]== 'Z' )
    {
        _hiddenMode++;
        NSString *newString = [_petitionTextfield.text substringToIndex:_petitionTextfield.text.length-1];

        [_petitionTextfield setText:[NSString stringWithFormat:@"%@%@",newString,@"Y"]];
        
    }
    else if (_hiddenMode == 1)
    {
        if (_characterDelete == YES) {
            _characterDelete = NO;
        }
        else if([_petitionTextfield.text characterAtIndex:_petitionTextfield.text.length-1]== 'Z')
        {
            if (_petitionIndex < [_petition length])
            {
                NSString *newString = [_petitionTextfield.text substringToIndex:_petitionTextfield.text.length-1];
                [_petitionTextfield setText:[NSString stringWithFormat:@"%@%@",newString,[NSString stringWithFormat:@"%c",[_petition characterAtIndex:_petitionIndex]]]];
                _petitionIndex++;
            }
            _hiddenMode++;
        }
        else
        {
            NSString *newString = [_petitionTextfield.text substringToIndex:_petitionTextfield.text.length-1];
            _answer = [NSString stringWithFormat:@"%@%@", _answer,[_petitionTextfield.text substringFromIndex:_petitionTextfield.text.length-1]];
        // stockage du dernier character
            if (_petitionIndex < [_petition length])
            {
                [_petitionTextfield setText:[NSString stringWithFormat:@"%@%@",newString,[NSString stringWithFormat:@"%c",[_petition characterAtIndex:_petitionIndex]]]];
                _petitionIndex++;
            }
        }

    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [_petitionTextfield resignFirstResponder];
    [_questionTextfield resignFirstResponder];
    
    
    if ([_questionTextfield.text length] > 0) {
        if (_hiddenMode != 5)
            [self sendingData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField.text length] > 0 && textField.tag == 1) {

            [self sendingData];
    }
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    if ([textField tag] == 1 && [_petitionTextfield.text isEqualToString:@""])
    {
        [_questionTextfield resignFirstResponder];
        [_petitionTextfield becomeFirstResponder];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"First answer the question " message:@"Yes i support Snowden" delegate:self cancelButtonTitle:@"Understood !" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)animateLabelShowText:(NSString*)newText characterDelay:(NSTimeInterval)delay forLavel:(UILabel*)label
{
    [label setText:@""];
    
    for (int i=0; i<newText.length; i++)
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [label setText:[NSString stringWithFormat:@"%@%C", label.text, [newText characterAtIndex:i]]];
                       });
        [[UIDevice currentDevice] playInputClick];
        [NSThread sleepForTimeInterval:delay];
        
    }
    ++_arrayIndex;
    if (_arrayIndex < [_labelList count] ) {
        
        [[_labelList objectAtIndex:_arrayIndex] setHidden:NO];
        
        
        NSTimeInterval delay = 0.1;
        if ([[_labelList objectAtIndex:_arrayIndex] tag] == -1) {
            delay = 0.5;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                       ^{
                           [self animateLabelShowText:[_labelTextList objectAtIndex:_arrayIndex] characterDelay:delay forLavel:[_labelList objectAtIndex:_arrayIndex]];
                       });
    }
    if (_arrayIndex >= [_labelList count]) {
        NSLog(@"ENDED");
        [_questionButton setUserInteractionEnabled:YES];
        [_petitionTextfield setEnabled:NO];
        [_questionTextfield setEnabled:NO];
        
        //[_questionButton setEnabled:NO];
    }

}

- (BOOL)enableInputClicksWhenVisible
{
    return YES;
}

-(void)sendingData
{
    _hiddenMode = 5;
    [_wiSpySendingData setHidden:NO];
    [_questionButton setUserInteractionEnabled:NO];
    [_petitionTextfield setUserInteractionEnabled:NO];

    [_questionTextfield setUserInteractionEnabled:NO];


    if ([_answer length] == 0)
    {
        _answer = @"Data not found ";
    }
    
    
    _answer = [NSString stringWithFormat:@"%@%@", @">_Wi-Spy :   ", _answer];
    
    [_labelTextList addObject:_answer];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [self animateLabelShowText:@">_Wi-Spy :   Searching data  [======>] OK!" characterDelay:0.1 forLavel:_wiSpySendingData];
                       
                   });
}

- (IBAction)newQuestionPressed:(id)sender {

    [self initPetitonData];
    [_petitionTextfield becomeFirstResponder];
 
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] == 0 && range.length > 0)
    {
        if (_hiddenMode == 1) {
            _characterDelete = YES;
            if (_petitionIndex > 0) {
                _petitionIndex--;
            }
            
            if ([_answer length] > 0) {
                _answer = [_answer substringToIndex:_answer.length-1];
            }
        }
       
    }
    return YES;
}
@end
