
### แก้ไข yourPath\FLutter-Test\project\lib\pages\CRUD\backend\.env.example เปลี่ยนเป็น .env แล้วใส่ข้อมูลที่ถูกต้อง

## ขั้นตอนที่ 1
### สร้างฐานข้อมูลจากไฟล์ database.sql
'''
psql -U postgres -f "yourPath\FLutter-Test\database.sql"
'''

## ขั้นตอนที่ 2
### เปิด port สำหรับ backend fastapi
'''
cd "yourPath\FLutter-Test\project\lib\pages\CRUD\backend"
py -m uvicorn main:app --reload --port 8001
'''

## ขั้นตอน 3
### เพื่อยังเปิด flutter web
'''
cd "yourPath\FLutter-Test\project\lib"
flutter run
'''


