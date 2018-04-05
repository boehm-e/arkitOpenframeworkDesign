#pragma once

#include "ofxiOS.h"
#include "ofxARKit.h"
class ofApp : public ofxiOSApp {
    
public:
    
    ofApp (ARSession * session);
    ofApp();
    ~ofApp ();
    
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);
    void touchCancelled(ofTouchEventArgs &touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    ofImage getFrameFromCamera(ARRef processor);

    
    ofTrueTypeFont font;
    
    ofCamera camera;
    
    // ====== AR STUFF ======== //
    ARSession * session;
    ARRef processor;
    
    vector <ofImage> frames;
    bool isDown = false;
    vector<vector<ofImage>> videos;
    int i;
    int video_current_index = 0;
    int video_current_frame = 0;
};


