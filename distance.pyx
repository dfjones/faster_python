import math
import time

cdef extern from "math.h":
    float sinf(float)
    float asinf(float)
    float sqrtf(float)
    float cosf(float)

cdef float pi = math.pi
cdef float radius = 6371.0

cdef float degree_to_radian(float deg):
    return deg * (pi / 180)

cdef float distance(float latA, float lngA, float latB, float lngB):
    cdef float latAr = degree_to_radian(latA)
    cdef float lngAr = degree_to_radian(lngA)
    cdef float latBr = degree_to_radian(latB)
    cdef float lngBr = degree_to_radian(lngB)

    cdef float deltaLat = latBr - latAr
    cdef float deltaLng = lngBr - lngAr

    return radius * 2 * asinf(sqrtf(
            sinf(deltaLat/2)**2 + cosf(latAr)
            * cosf(latBr) * (sinf(deltaLng/2)**2)))

def bench():
    increment = 2.5

    start = time.time()
    latA = -90
    while(latA <= 90):
        lngA = -180
        while(lngA <= 180):
            latB = -90
            while(latB <= 90):
                lngB = -180    
                while(lngB <= 180):
                    distance(latA, lngA, latB, lngB)
                    lngB = lngB + increment
                latB = latB + increment
            lngA = lngA + increment
        latA = latA + increment
    end = time.time()
    print end-start

if __name__ == '__main__':
    bench()
