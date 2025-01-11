import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_regex.dart';
import 'package:globipay_admin_panel/modules/authetication/login/controller/login_controller.dart';
/**
 * Created by Abdullah on 8/12/24.
 */

class LoginScreenBuilder extends StatefulWidget {
  const LoginScreenBuilder({super.key});

  @override
  State<LoginScreenBuilder> createState() => _LoginScreenBuilderState();
}

class _LoginScreenBuilderState
    extends BaseViewState<LoginScreenBuilder, LoginController> {

  late List<Particle> particles;
  @override
  initState() {
    controller.onInit();
    particles = [];
    for (int i = 0; i < 80; i++) {
      particles.add(
          Particle(
            width: 600,
            height: 701,
          )
      );
    }
    update();
    super.initState();
  }


  @override
  Widget body(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (details){
          particles.add(
              Particle(
                  width: 600,
                  height: 701
              )..x = details.localPosition.dx
                ..y = details.localPosition.dy
          );

          if(particles.length > 400){
            particles.removeRange(400, particles.length - 1);
          }

        },
        child: CustomPaint(
          painter: ParticlePainter(particles: particles),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.9),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
          // App Logo or Welcome Text
                      Text(
                        'Admin Panel',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      InputField(
                        controller: controller.emailController,
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        regex: InputRegex.EMAIL,
                      ),
                      const SizedBox(height: 20),


          // Password Field
                      InputField(
                        controller: controller.passwordController,
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        regex: InputRegex.NOT_EMPTY,
                      ),

                      const SizedBox(height: 20),

          // Remember Me Checkbox
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.isRememberMeChecked.value,
                              onChanged: (value) {
                                controller.toggleRememberMe(value ?? false);
                              },
                            ),
                            const Text('Remember Me'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

          // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            controller.login();
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  update(){
    Timer.periodic(Duration(milliseconds: 16), (timer){
      setState(() {
      });
    });
  }
}


class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < particles.length -1; i++) {
      var current = particles[i];
      current.x += current.xSpeed;
      current.y += current.ySpeed;

      if(current.x > size.width || current.x < 0){
        current.xSpeed *= -1;
      }

      if(current.y > size.height || current.y < 0){
        current.ySpeed *= -1;
      }


      for(int j = i + 1; j < particles.length; j++){
        var next = particles[j];
        var distance = distanceBetweenTwoPoints(current.x, current.y, next.x, next.y);
        if(distance < 100){
          var paintLine = Paint()
            ..color = Colors.black12
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1;

          var point1 = Offset(current.x, current.y);
          var point2 = Offset(next.x, next.y);

          canvas.drawLine(point1, point2, paintLine);
        }
      }
      var pointPaint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill;

      var circlePosition = Offset(current.x, current.y);
      canvas.drawCircle(
          circlePosition,
          current.radius,
          pointPaint
      );

    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


  double distanceBetweenTwoPoints(double x1, double y1, double x2, double y2){
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2)); // distance formula
  }
}

class Particle{
  double height;
  double width;
  late double radius;
  late double xSpeed;
  late double ySpeed;
  late double x;
  late double y;

  Particle({required this.height, required this.width}){
    x = Random().nextDouble() * width;
    y = Random().nextDouble() * height;
    radius = Random().nextDouble() * 9;


    xSpeed = Random().nextDouble() * 3;
    ySpeed = Random().nextDouble() * 1.5;
  }


}