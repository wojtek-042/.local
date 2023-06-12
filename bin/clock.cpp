#define _SILENCE_EXPERIMENTAL_FILESYSTEM_DEPRECATION_WARNING
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <opencv2/opencv.hpp>
#include <string>
#include <thread>

extern "C" {
#include <X11/Xlib.h>
#include <X11/Xresource.h>
#include <X11/Xutil.h>
#include <X11/extensions/Xrandr.h>
}

using namespace std;

bool isKeyPressed(Display *display, KeyCode keycode) {
  char keys[32];
  XQueryKeymap(display, keys);
  return keys[keycode >> 3] & (1 << (keycode & 7));
}

void takeScreenshot(const string &filename) {
  Display *display = XOpenDisplay(NULL);
  Window root = DefaultRootWindow(display);

  XWindowAttributes attributes;
  XGetWindowAttributes(display, root, &attributes);
  int width = attributes.width;
  int height = attributes.height;

  XImage *image =
      XGetImage(display, root, 0, 0, width, height, AllPlanes, ZPixmap);

  cv::Mat screenshot(height, width, CV_8UC4, image->data);

  cv::imwrite(filename, screenshot);

  XDestroyImage(image);
  XCloseDisplay(display);
}

void lockComputer(const string &bgName) {
  string lockCommand = "i3lock -i " + bgName;
  const char *command = lockCommand.c_str();
  system(command);
}

void takeWebcamPicture(const string &directory) {
  cv::VideoCapture camera(0);
  if (!camera.isOpened()) {
    cerr << "Failed to open the camera" << endl;
    return;
  }

  cv::Mat frame;
  camera >> frame;
  camera.release();

  string timestamp = to_string(time(nullptr));
  string filename = directory + "/webcam_" + timestamp + ".jpg";
  cv::imwrite(filename, frame);
  cout << "Webcam picture saved: " << filename << endl;
}

bool monitorMouseMovement(const string &directory, int maxPictures) {
  Display *display = XOpenDisplay(NULL);
  Window root = DefaultRootWindow(display);

  Window child;
  int rootX, rootY, winX, winY;
  unsigned int mask;

  KeyCode escapeKeyCode = XKeysymToKeycode(display, XK_Escape);

  int pictureCounter = 0;
  XQueryPointer(display, root, &root, &child, &rootX, &rootY, &winX, &winY,
                &mask);
  int lastX = rootX;
  int lastY = rootY;
  while (true) {
    XQueryPointer(display, root, &root, &child, &rootX, &rootY, &winX, &winY,
                  &mask);
    if (rootX != lastX || rootY != lastY) {
      takeWebcamPicture(directory);
      pictureCounter++;
      if (pictureCounter >= maxPictures) {
        cout << "Maximum number of pictures reached. Stopping..." << endl;
        XCloseDisplay(display);
        return true;
      }
    }
    lastX = rootX;
    lastY = rootY;

    if (isKeyPressed(display, escapeKeyCode)) {
      cout << "Escape key pressed. Terminating..." << endl;
      XCloseDisplay(display);
      return false;
    }

    this_thread::sleep_for(chrono::milliseconds(500));
  }

  XCloseDisplay(display);
  return false;
}

int main() {
  string directory = "/home/ap/Pictures"; // Change directory if needed

  string backgroundPath = directory + "/background.png";
  bool bgExists = std::filesystem::exists(backgroundPath);
  if (!bgExists) {
    takeScreenshot(backgroundPath);
  }

  lockComputer(backgroundPath);

  int maxPictures = 5;
  bool maxPicturesReached = monitorMouseMovement(directory, maxPictures);

  if (maxPicturesReached) {
    cout << "Exiting program after taking " << maxPictures << " pictures."
         << endl;
    return 0;
  }

  return 0;
}

