import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceCard({Key? key, required this.service, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0XFF2C2D31), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Positioned.fill(
                    child:
                        service.backgroundImage.isNotEmpty
                            ? service.backgroundImage.startsWith('http')
                                ? Image.network(
                                  service.backgroundImage,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  service.backgroundImage,
                                  fit: BoxFit.cover,
                                )
                            : Container(color: const Color(0XFF202126)),
                  ),

         
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0XFF202126).withOpacity(0.9),
                      ),
                    ),
                  ),

         
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildServiceIcon(),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                service.title,
                                style: GoogleFonts.syne(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),

                              Text(
                                service.description,
                                style: GoogleFonts.syne(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_right, color: Colors.white, size: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIcon() {
    const double iconSize = 47;

    if (service.iconPath.isNotEmpty) {
      if (service.iconPath.startsWith('http')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            service.iconPath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _getFallbackIcon(service.title);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
          ),
        );
      } else if (service.iconPath.startsWith('assets/')) {
        return Image.asset(
          service.iconPath,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _getFallbackIcon(service.title);
          },
        );
      }
    }
    return _getFallbackIcon(service.title);
  }

  Widget _getFallbackIcon(String title) {
    const iconColor = Colors.white;
    const iconSize = 24.0;

    switch (title.toLowerCase()) {
      case 'music production':
        return Icon(Icons.music_note, color: iconColor, size: iconSize);
      case 'mixing & mastering':
        return Icon(Icons.tune, color: iconColor, size: iconSize);
      case 'lyrics writing':
        return Icon(Icons.edit, color: iconColor, size: iconSize);
      case 'vocals':
        return Icon(Icons.mic, color: iconColor, size: iconSize);
      default:
        return Icon(Icons.music_note, color: iconColor, size: iconSize);
    }
  }
}
