import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() {
    return ProductDetailState();
  }
}

class ProductDetailState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Bounceable(
                        scaleFactor: 0.7,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 35.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.r),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Detail Product',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                      Container(
                        width: 35.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.r),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.w),
                        child: Stack(
                          children: [
                            Image.asset('assets/images/mens_wear.jpg',
                                height: 200.h),
                            Positioned(
                              bottom: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0.w),
                                    child: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: index == 1
                                              ? const Color.fromARGB(
                                                  255, 234, 163, 56)
                                              : Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Image.asset(
                                          'assets/images/mens_wear.jpg'),
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Lebeni Jackets',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  const Text('Classic Winter Jacket'),
                ]),
                Text(
                  '\$699.00',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ]),
              SizedBox(height: 8.0.h),
              Text(
                'Select Size',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Row(
                children: ['S', 'M', 'L', 'XL'].map((size) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.r),
                    child: ChoiceChip(
                      label: Text(size),
                      selected: size == 'M',
                      selectedColor: const Color.fromARGB(255, 234, 163, 56),
                      onSelected: (value) {},
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {},
                  ),
                  const Text('02'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'Description',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text(
                'When users select an item, they are taken to a sleek cart interface... ',
              ),
              const Text(
                'Learn More',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 120.w,
                    height: 35.h,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Buy Now',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0.w),
                  Expanded(
                    child: SizedBox(
                      height: 35.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 234, 163, 56)),
                        onPressed: () {},
                        child: Text(
                          'Add to cart',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
