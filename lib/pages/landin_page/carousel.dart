import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<String> images = [
    'assets/images/3x3one.png',
    'assets/images/3x3two.jpeg',
    'assets/images/3x3three.jpeg',
  ];
  final List<Map<String, String>> carouselContent = [
    {
      'tag': '3X3 BASKETBALL',
      'title': 'POLAND TO HOST FIBA\n3X3 WORLD CUP 2026',
    },
    {'tag': 'FIBA NEWS', 'title': 'TOP TEAMS FROM AROUND\nTHE WORLD COMPETE'},
    {
      'tag': 'SPORTS EVENT',
      'title': 'FAST-PACED ACTION AND\nGLOBAL COMPETITION',
    },
  ];

  late final autoPlayInterval = const Duration(seconds: 15);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      startAutoPlay();
    });
  }

  void startAutoPlay() async {
    while (true) {
      await Future.delayed(autoPlayInterval);

      if (currentPage < images.length - 1) {
        await _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        currentPage++;
      } else {
        await _controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        currentPage = 0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 500),

        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
              ),

              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            carouselContent[currentPage]['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              letterSpacing: -1.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF8b0000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.342,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8b0000),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      carouselContent[currentPage]['tag']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Nav Arrows
              Positioned(
                top: 0,
                left: 16,
                right: 16,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed:
                            () => _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed:
                            () => _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      images.asMap().entries.map((entry) {
                        return Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                currentPage == entry.key
                                    ? Colors.white
                                    : Colors.white60,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
