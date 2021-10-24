# flutter เชื่อมกับ Firebasse NoSQL

ระบบ Register/Login โดยเชื่อมต่อกับฐานข้อมูล Firebase

## Document
### Login.dart
ใน welcome.dart จะมี class Login() เป็นหน้าหลักที่ใช้ในการ Login เข้าสุ่ระบบ ที่มีปุ่ม Login กับ Register โดยเมื่อกดแต่ละปุุ่ม จะมีการใช้คำสั่ง Navigator.push() ทำการ return Welcome() และ Register() 
เพื่อแสดงหน้า Welcome และ Register
![6](https://user-images.githubusercontent.com/48234119/138599965-507d770b-02c9-42d9-a444-1f389398024b.png)
![7](https://user-images.githubusercontent.com/48234119/138600124-877c6725-0280-47fe-af47-7ad3eefbb4c6.png)

### Profile.dart
จะมีตัวแปร email กับ password เป็นการสร้างตัวแปรที่ไว้ รับ ส่ง ข้อมูล

![1](https://user-images.githubusercontent.com/48234119/138600633-df973708-320f-4e08-9a2a-69a4b51da2d8.png)

### Register.dart
ใน register.dart จะมี class Register() ที่มีตัวแปร _formKey สำหรับเก็บ key ของ Form() , profile สำหรับเก็บ instance ของโมเดล Profile , _firebase สำหรับเชื่อมต่อกับ firebase


![2](https://user-images.githubusercontent.com/48234119/138600298-91287084-d0f5-4f6a-8c15-cc46eb0e0ee1.png)


ใน Form() จะมี TextFormField() ที่ใช้รับข้อมูล Email กับ Password และมีการ validator ข้อมูล จากนั้นก็เก็บข้อมูลไว้ในตัวแปร profile ในแต่ละส่วน

![3](https://user-images.githubusercontent.com/48234119/138600358-abe5f2b4-5f20-4ed9-9ba8-eb85ee2c44ca.png)

และมีปุ่ม Register ที่จะเรียกใช้คำสั่ง FirebaseAuth.instance.createUserWithEmailAndPassword() เพื่อ ส่งค่าใน profile ไปสร้างในฐานข้อมูล firebase

![4](https://user-images.githubusercontent.com/48234119/138600462-3e92b495-5366-4efa-9bea-6c2a4ee5d630.png)

### home.dart
ใน home.dart ที่มีตัวแปร _auth สำหรับเก็บ instance Firebase จะมีปุ่ม Logout ที่เรียกใช้ _ auth.signOut() เพื่อทำการ Logout

![5](https://user-images.githubusercontent.com/48234119/138600525-d9a5969c-47df-4772-9901-f1d1b03a82e1.png)


