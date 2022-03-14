import Foundation
import MetalKit
import Metal

class Transforms {

    static let k1Div180_f = Float(1) / Float(180)
    static let kRadians = k1Div180_f * .pi;
    
    static func radians(fromDegrees degrees: Float) -> Float {
        return kRadians * degrees
    }
    
    static func radiansOverPI(degrees: Float) -> Float {
        return degrees * k1Div180_f
    }
    
    static func perspective_fov(fovy: Float, width: Float, height: Float, near: Float, far: Float) -> simd_float4x4 {
        let aspect = width / height
        
        return perspective_fov(fovy: fovy, aspect: aspect, near: near, far: far)
    }
    
    static func perspective_fov(fovy: Float, aspect: Float, near: Float, far: Float) -> simd_float4x4 {
        let angle = radians(fromDegrees: 0.5 * fovy)
        let yScale = 1 / tan(angle)
        let xScale = yScale / aspect
        let zScale = far / (far - near)
        
        let p = simd_float4(xScale, 0, 0, 0)
        let q = simd_float4(0, yScale, 0, 0)
        let r = simd_float4(0, 0, zScale, 1)
        let s = simd_float4(0, 0, -near * zScale, 0)
        
        return simd_float4x4(p, q, r, s)
    }
    
    static func lookAt(eye: simd_float3, center: simd_float3, up: simd_float3) -> simd_float4x4 {
        let zAxis = simd_normalize(center - eye)
        let xAxis = simd_normalize(simd_cross(up, zAxis))
        let yAxis = simd_cross(zAxis, xAxis)
        
        let p = simd_float4(xAxis.x, yAxis.x, zAxis.x, 0)
        let q = simd_float4(xAxis.y, yAxis.y, zAxis.y, 0)
        let r = simd_float4(xAxis.z, yAxis.z, zAxis.z, 0)
        let s = simd_float4(simd_dot(xAxis, eye),
                            simd_dot(yAxis, eye),
                            simd_dot(zAxis, eye),
                            1)
        
        return simd_float4x4(p, q, r, s)
    }
    
    static func matrix4_mul_vector3(m: simd_float4x4, v: simd_float3) -> simd_float3 {
        var temp = simd_float4(v.x, v.y, v.z, 0)
        temp = simd_mul(m, temp)
        return simd_float3(temp.x, temp.y, temp.z)
    }
    
    static func rotate(angle: Float, r: simd_float3) -> simd_float4x4 {
        let a = radiansOverPI(degrees: angle)
        var c = Float.zero
        var s = Float.zero
        
        __sincospif(a, &s, &c)
        
        let k = Float(1) - c
        
        let u = simd_normalize(r)
        let v = s * u
        let w = k * u
        
        let P = simd_float4(w.x * u.x + c,
                            w.x * u.y + v.z,
                            w.x * u.z - v.y,
                            0)
        let Q = simd_float4(w.x * u.y - v.z,
                            w.y * u.y + c,
                            w.y * u.z + v.x,
                            0)
        let R = simd_float4(w.x * u.z + v.y,
                            w.y * u.z - v.x,
                            w.z * u.z + c,
                            0)
        let S = simd_float4(0, 0, 0, 1)
        
        return simd_float4x4(P, Q, R, S)
    }
    
    static func rotate(angle: Float, x: Float, y: Float, z: Float) -> simd_float4x4 {
        let r = simd_float3(x, y, z)
        
        return rotate(angle: angle, r: r)
    }
}
