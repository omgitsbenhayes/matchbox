//
//  ViewController.m
//  MatchBox
//
//  Created by Matthew McHugh on 4/5/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *matchboxLogo;
@property (strong, nonatomic) FBRequestConnection *requestConnection;

-(void)addFBLoginView;
- (IBAction)buttonClickHandler:(id)sender;
- (void)updateView;
- (void)sendRequest;
- (void)sendFriendListRequest;
- (void)requestCompleted:(FBRequestConnection *)connection
                 forFbID:(NSString *)fbID
                  result:(id)result
                   error:(NSError *)error;

@end

@implementation ViewController

@synthesize friendsList;
@synthesize firstTime;
@synthesize friendsLoaded;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.matchboxLogo.text = @"matchbox";
    self.matchboxLogo.textColor = [UIColor grayColor];
    self.matchboxLogo.font = [UIFont fontWithName:@"ArialMT" size:24];
    [self updateView];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if(!appDelegate.session.isOpen)
    {
        //create a new session object
        appDelegate.session = [[FBSession alloc]init];
        
        //check to make sure that a token exists before calling to open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded)
        {
            //cached token exists; login still needed
            [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error){
                [self updateView];
            }];
        }
    }
    else{
        NSLog(@"Session open");
        [self updateView];
    }
    
    //[self addFBLoginButton];
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    NSLog(@"did become active notification");
    [self updateView];
}

- (void)appDidEnterForeground:(NSNotification *)notification {
    NSLog(@"did enter foreground notification");
}

// updates view to reflect the status of the session
-(void)updateView
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen){
        
        //****Custom Facebook Login Button****
        
        //[self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        //[self.textNoteOrLink setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@", appDelegate.session.accessTokenData.accessToken]];
        //[self sendRequest];
        self.friendsLoaded = NO;
        [self sendFriendListRequest];
        //[self performSelector:@selector(loadMatchBoxViewController) withObject:friendsList afterDelay:0.0];
    }
    else{
        //[self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
        //[self.textNoteOrLink setText:@"Login to create a link to fetch account data"];
        [self addFBLoginView];
        NSLog(@"Session not open");
    }
}

//****Method to handle custom Login Button****
-(IBAction)buttonClickHandler:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if(appDelegate.session.isOpen)
    {
        [appDelegate.session closeAndClearTokenInformation];
    }
    else
    {
        if(appDelegate.session.state != FBSessionStateCreated){
            appDelegate.session = [[FBSession alloc]init];
        }
        [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error){
            [self updateView];
        }];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFBLoginView
{
    FBLoginView *loginView = [[FBLoginView alloc] init];
    // Align the button in the center horizontally and vertically
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), (self.view.center.y - (loginView.frame.size.height / 2)));
    [self.view addSubview:loginView];
}

- (void)sendRequest
{
    NSString *fbid = @"/me";
    
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    
    // create a handler block to handle the results of the request for fbid's profile
    FBRequestHandler handler =
    ^(FBRequestConnection *connection, id result, NSError *error) {
        // output the results of the request
        [self requestCompleted:connection forFbID:fbid result:result error:error];
    };
    
    // create the request object, using the fbid as the graph path
    // as an alternative the request* static methods of the FBRequest class could
    // be used to fetch common requests, such as /me and /me/friends
    FBRequest *request = [[FBRequest alloc] initWithSession:FBSession.activeSession
                                                  graphPath:fbid];
    
    // add the request to the connection object, if more than one request is added
    // the connection object will compose the requests as a batch request; whether or
    // not the request is a batch or a singleton, the handler behavior is the same,
    // allowing the application to be dynamic in regards to whether a single or multiple
    // requests are occuring
    [newConnection addRequest:request completionHandler:handler];
    
    // if there's an outstanding connection, just cancel
    [self.requestConnection cancel];
    
    // keep track of our connection, and start it
    self.requestConnection = newConnection;
    [newConnection start];
    NSLog(@"Request Sent");
    
}

- (void)sendFriendListRequest
{
    NSString *fbid = @"/me";
    
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    
    // create a handler block to handle the results of the request for fbid's profile
    FBRequestHandler handler =
    ^(FBRequestConnection *connection, id result, NSError *error) {
        // output the results of the request
        [self requestCompleted:connection forFbID:fbid result:result error:error];
    };
    
    // create the request
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        NSLog(@"Found: %i friends", friends.count);
        [self generateFriendsList:friends];
        [self performSelector:@selector(loadMatchBoxViewController) withObject:friendsList afterDelay:0.0];
    }];
    
    [newConnection addRequest:friendsRequest completionHandler:handler];
    
    // if there's an outstanding connection, just cancel
    [self.requestConnection cancel];
    
    // keep track of our connection, and start it
    self.requestConnection = newConnection;
    [newConnection start];
    NSLog(@"Request Sent");
}

- (void)requestCompleted:(FBRequestConnection *)connection
                 forFbID:fbID
                  result:(id)result
                   error:(NSError *)error {
    // not the completion we were looking for...
    if (self.requestConnection &&
        connection != self.requestConnection) {
        return;
    }
    
    // clean this up, for posterity
    self.requestConnection = nil;
    
    NSString *text;
    if (error) {
        // error contains details about why the request failed
        text = error.localizedDescription;
    } else {
        // result is the json response from a successful request
        NSDictionary *dictionary = (NSDictionary *)result;
        // we pull the name property out, if there is one, and display it
        text = (NSString *)[dictionary objectForKey:@"name"];
    }
    NSLog(@"Text is %@", text);
}

-(void) generateFriendsList: (NSArray *) list
{
    friendsList = [[FBFriendsList alloc]init];
    for (NSDictionary<FBGraphUser>* friend in list) {
        //NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
        NSString *friendName = friend.name;
        NSString *friendFBID = friend.id;
        NSString *friendPhotoURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [friend username]];
        [friendsList addFriendToList:[[FBFriend alloc] initWithName:friendName andFBID:friendFBID andFBPhoto:friendPhotoURL]];
        
    }
    //NSLog(@"Friend List count before matchbox creation: %d", [friendsList.fbFriendsList count]);
    //MatchBox *mb = [[MatchBox alloc] initWithFriendsList:friendsList];
    //[mb generateMatchBox];
}

- (void) loadMatchBoxViewController
{
    [self performSegueWithIdentifier:@"matchboxSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"matchboxSegue"]) {
        
        // Get destination view
        MatchBoxViewController *vc = [segue destinationViewController];
        
        [vc setFriendsList:friendsList];
        
        NSLog(@"Segue!");
        
    }
}

@end
