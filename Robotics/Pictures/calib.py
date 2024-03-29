#!/usr/bin/env python
 
import cv2
import numpy as np
import glob
#import sys
#import os
 

def calibrate(fileset):
    # Defining the dimensions of checkerboard
    CHECKERBOARD = (8,6)
    #criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 30, 0.001)
    
    # Creating vector to store vectors of 3D points for each checkerboard image
    objpoints = []
    # Creating vector to store vectors of 2D points for each checkerboard image
    imgpoints = [] 
    
    
    # Defining the world coordinates for 3D points
    objp = np.zeros((1, CHECKERBOARD[0] * CHECKERBOARD[1], 3), np.float32)
    objp[0,:,:2] = np.mgrid[0:CHECKERBOARD[0], 0:CHECKERBOARD[1]].T.reshape(-1, 2)
    #prev_img_shape = None
    
    # Extracting path of individual image stored in a given directory
    images = glob.glob(fileset)
    for fname in images:
        img = cv2.imread(fname) 
        gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        # Find the chess board corners
        # If desired number of corners are found in the image then ret = true
        ret, corners = cv2.findChessboardCorners(gray, CHECKERBOARD, None)
        
        """
        If desired number of corner are detected,
        we refine the pixel coordinates and display 
        them on the images of checker board
        """
        if ret == True:
            objpoints.append(objp)
            # refining pixel coordinates for given 2d points.
            #corners2 = cv2.cornerSubPix(gray, corners, (11,11),(-1,-1), criteria)
            imgpoints.append(corners)
            # Draw and display the corners
            cv2.drawChessboardCorners(img, CHECKERBOARD, corners, ret)
        else:
            print(f'\nCalibration points not found for image: {fname}\n')
        cv2.imshow('img',img)
        cv2.waitKey(10)
    
    cv2.destroyAllWindows()
    #gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #h,w = img.shape[:2]

    """
    Performing camera calibration by 
    passing the value of known 3D points (objpoints)
    and corresponding pixel coordinates of the 
    detected corners (imgpoints)
    """
    ret, mtx, dist, rvecs, tvecs = cv2.calibrateCamera(objpoints, imgpoints, gray.shape[::-1], None, None)
    
    r_matrices = [cv2.Rodrigues(rotation)[0] for rotation in rvecs]

    print("Camera matrix : \n")
    print(mtx)
    print("dist : \n")
    print(dist)
    print("r_matrices : \n")
    print(len(rvecs))
    print(r_matrices)
    print("tvecs : \n")
    print(tvecs)

    return mtx, r_matrices, tvecs



right_files = 'right*.ppm'
left_files = 'left*.ppm'

R_intrinsic, R_rvecs, R_translations = calibrate(right_files)
L_intrinsic, L_rvecs, L_translations = calibrate(left_files)
