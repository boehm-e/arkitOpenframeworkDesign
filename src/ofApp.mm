#include "ofApp.h"


//--------------------------------------------------------------
ofApp :: ofApp (ARSession * session){
    this->session = session;
    cout << "creating ofApp" << endl;
}

ofApp::ofApp(){}

//--------------------------------------------------------------
ofApp :: ~ofApp () {
    cout << "destroying ofApp" << endl;
}

//--------------------------------------------------------------
void ofApp::setup() {
    ofBackground(127);
    ofLogToConsole();

//    img.load("seedup.png");
    
    int fontSize = 8;
    if (ofxiOSGetOFWindow()->isRetinaSupportedOnDevice())
        fontSize *= 2;
    font.load("fonts/mono0755.ttf", fontSize);
    
    processor = ARProcessor::create(session);
    processor->setup();
}

//--------------------------------------------------------------
void ofApp::update(){
    processor->update();
}

//--------------------------------------------------------------
void ofApp::draw() {
    ofEnableAlphaBlending();
    
    ofDisableDepthTest();
    processor->draw();
    ofEnableDepthTest();
    i = 0;
    processor->anchorController->loopAnchors([=](ARObject obj)->void {
        camera.begin();
        processor->setARCameraMatrices();
        
        ofPushMatrix();
        ofMultMatrix(obj.modelMatrix);

        ofSetColor(255);
        ofRotate(-90,0,0,1);

        if (i%3 == 1) {
            ofSetColor(255, 0, 0, 150);
        } else if (i%2==0) {
            ofSetColor(0, 255, 0, 150);
        } else {
            ofSetColor(0, 0, 255, 150);
        }
        if(frames[i].getWidth() > 1) {
//            ofRectangle(0,0,200,200);
            frames[i].draw(-(0.25 / 2),-(0.44 / 2),0.25,0.44);
            i+=1;
        }
        
        

        ofPopMatrix();
        
        camera.end();
        
    });
    
    ofDisableDepthTest();
    // ========== DEBUG STUFF ============= //
   
    processor->debugInfo.drawDebugInformation(font);

    
}

//--------------------------------------------------------------
void ofApp::exit() {
    //
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs &touch){
//    ofLogNotice() << "screenHeight : " << ofGetScreenHeight() << "|| height : " << ofGetHeight();
//    ofLogNotice() << "screenWidth : " << ofGetScreenWidth() << "|| width : " << ofGetWidth();

    //-- on click : grab image and add it to image array
    ofTexture texture = processor->getCameraTexture();
    ofFbo fbo = processor->getFBO();
    ofPixels pixels;
    fbo.readToPixels(pixels);
    ofImage img;
    pixels.resize(pixels.getWidth()/4, pixels.getHeight()/4);
    pixels.mirror(false, true);
    img.setFromPixels(pixels);
    frames.push_back(img);
//    processor->addAnchor(ofVec3f(ofGetWidth()/2,ofGetHeight()/2, -0.2));
    processor->addAnchor();
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    processor->updateDeviceInterfaceOrientation();
    processor->deviceOrientationChanged();
}


//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs& args){
    
}


