//
//  Extensions&Helpers.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import SpriteKit

func + (rhs: CGPoint, lhs: CGPoint) -> CGPoint {
    return CGPoint(x: rhs.x+lhs.x, y: rhs.y+lhs.y)
}

func - (lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(x: lhs.x-rhs.width, y: lhs.y-rhs.height)
}

func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx/rhs, dy: lhs.dy/rhs)
}

func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width/rhs, height: lhs.height/rhs)
}

func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x/rhs, y: lhs.y/rhs)
}

func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx*rhs, dy: lhs.dy*rhs)
}

func distance(_ pointA: CGPoint, _ pointB: CGPoint) -> CGFloat {
    return sqrt((pointA.x-pointB.x)*(pointA.x-pointB.x) + (pointA.y-pointB.y)*(pointA.y-pointB.y))
}

func unitVector(_ pointA: CGPoint, _ pointB: CGPoint) -> CGVector {
    return CGVector(dx: pointB.x - pointA.x, dy: pointB.y - pointA.y)/distance(pointA, pointB)
}

//swiftlint:disable:next identifier_name
func translade(point: CGPoint, by: CGVector) -> CGPoint {
    return CGPoint(x: point.x + by.dx, y: point.y + by.dy)
}

extension CGVector {
    static func new(pointA: CGPoint, pointB: CGPoint) -> CGVector {
        return CGVector(dx: pointB.x - pointA.x, dy: pointB.y - pointA.y)
    }
    
    func norm() -> CGFloat {
        return sqrt((self.dx*self.dx)+(self.dy*self.dy))
    }
    
    func normalized() -> CGVector {
        return self / self.norm()
    }
    
}
