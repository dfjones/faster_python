import math
import time

radius = 6371

def distance(latA, lngA, latB, lngB):
    latAr = math.radians(latA)
    lngAr = math.radians(lngA)
    latBr = math.radians(latB)
    lngBr = math.radians(lngB)

    deltaLat = latBr - latAr
    deltaLng = lngBr - lngAr

    return radius * 2 * math.asin(math.sqrt(
            math.sin(deltaLat/2)**2 + math.cos(latAr)
            * math.cos(latBr) * (math.sin(deltaLng/2)**2)))

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
