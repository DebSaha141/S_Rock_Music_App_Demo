import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import '../widgets/service_card.dart';
import '../widgets/custom_bottom_nav.dart';
import 'service_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA90140),
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFFA90140),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
        color: const Color(0xFF18171C),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.38,
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFA90140), Color(0xFF550120)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    _buildHeader(context, screenWidth),
                    _buildPromoSection(context, screenWidth, screenHeight),
                  ],
                ),
              ),
              Expanded(
                child: _buildServicesList(context, screenHeight, screenWidth),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  Widget _buildHeader(BuildContext context, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF2F2F39),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Search.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white70),
                      decoration: InputDecoration(
                        hintText: 'Search “Punjabi Lyrics”',
                        hintStyle: GoogleFonts.syne(
                          color: const Color(0xFF61616B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  Container(width: 1, height: 24, color: Colors.white24),
                  const SizedBox(width: 12),
                  const Icon(Icons.mic, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFEADDFF),
            child: Image.asset(
              'assets/images/person.png',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      height: screenHeight * 0.25,
      width: screenWidth,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Claim your',
                    style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,

                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Free Demo',
                    style: GoogleFonts.lobster(
                      color: Colors.white,
                      height: 1.15,
                      fontSize: screenWidth * 0.125,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'for custom Music Production',
                    style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.012,
                      ),
                    ),
                    child: Text(
                      'Book Now',
                      style: GoogleFonts.syne(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -screenWidth * 0.09,
            bottom: -2,
            child: Image.asset(
              'assets/images/vinyl.png',
              width: screenWidth * 0.32,
            ),
          ),
          Positioned(
            right: -screenWidth * 0.1,
            bottom: 0,
            child: Image.asset(
              'assets/images/piano.png',
              width: screenWidth * 0.32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList(
    BuildContext context,
    double screenHeight,
    double screenWidth,
  ) {
    print("Building services list");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: Color(0xFF18171C)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Text(
              'Hire hand-picked Pros for popular music services',
              style: GoogleFonts.syne(
                color: Colors.white,
                fontSize: screenWidth * 0.040,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 22),
            Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  );
                }

                if (viewModel.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${viewModel.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: viewModel.refreshServices,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children:
                      viewModel.services.map((service) {
                        return ServiceCard(
                          service: service,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ServiceDetailScreen(
                                      serviceName: service.title,
                                      serviceIcon: service.iconPath,
                                    ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                );
              },
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
