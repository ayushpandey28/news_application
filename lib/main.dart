import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
// import 'dart:math' as math;

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const NewsApp());
}

// ============================================================================
// MODELS & DATA
// ============================================================================

class Article {
  String id;
  String title;
  String description;
  String content;
  String imageUrl;
  String category;
  String date;
  bool isBookmarked;
  String author;
  int readTime;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.date,
    this.isBookmarked = false,
    this.author = 'Staff Reporter',
    this.readTime = 3,
  });
}

List<Article> globalArticles = [
  Article(
    id: '1',
    title: 'The Future of AI in Everyday Life',
    description: 'Artificial intelligence is steadily integrating into our daily tools and routines.',
    content:
        'Artificial intelligence is rapidly evolving. From home automation to personalized learning, AI promises to bring about a new era of efficiency. However, concerns regarding data privacy and job displacement remain high. The real question is how society will adapt to these profound technological shifts.\n\nExperts predict that within the next decade, AI will be embedded in everything from healthcare diagnosis to personal finance management. The convergence of machine learning, natural language processing, and computer vision is creating systems that were once thought to be decades away.\n\nAs we stand at this technological crossroads, one thing is certain: the relationship between humans and machines is being fundamentally redefined.',
    imageUrl:
        'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=1000',
    category: 'Technology',
    date: '2 Hrs Ago',
    author: 'Priya Sharma',
    readTime: 4,
  ),
  Article(
    id: '2',
    title: 'Championship Finals: A Historic Victory',
    description: 'An unbelievable finish to this year\'s biggest sports event leaves fans in awe.',
    content:
        'In a stunning turnaround, the underdog team claimed victory in the final seconds. Crowds erupted as the final whistle blew. This match will be remembered as one of the greatest comebacks in sports history, challenging everything analysts had predicted.\n\nThe team, written off by most pundits before the tournament began, displayed extraordinary resilience throughout the competition. Their journey from the group stages to the championship final has become the defining sports story of the year.\n\nAs confetti rained down on the victorious players, their captain raised the trophy to thunderous applause, cementing their place in sporting legend.',
    imageUrl:
        'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?auto=format&fit=crop&q=80&w=1000',
    category: 'Sports',
    date: '5 Hrs Ago',
    isBookmarked: true,
    author: 'Rahul Verma',
    readTime: 3,
  ),
  Article(
    id: '3',
    title: 'New Policy Debated in Senate',
    description: 'Legislators are divided over the newly proposed economic policies.',
    content:
        'The Senate floor saw heated debates today regarding the new fiscal stimulus plan. Key figures argued over its potential impact on inflation and middle-class taxation. The vote is scheduled for tomorrow, and national attention is closely following the outcome.\n\nThe proposed bill, running to over 400 pages, includes sweeping changes to corporate tax structures and introduces new social welfare programs. Opposition leaders have called the plan "fiscally reckless," while proponents argue it will create over two million jobs.\n\nMarkets responded nervously to the uncertainty, with indices closing slightly down as investors await the final vote.',
    imageUrl:
        'https://images.unsplash.com/photo-1540910419892-4a36d2c3266c?auto=format&fit=crop&q=80&w=1000',
    category: 'Politics',
    date: '1 Day Ago',
    author: 'Ananya Gupta',
    readTime: 5,
  ),
  Article(
    id: '4',
    title: 'Blockbuster Sequel Shatters Records',
    description: 'The highly anticipated movie opens to massive global box office numbers.',
    content:
        'Earning over \$100 million in its opening weekend, the sequel has redefined what success looks like in the post-pandemic entertainment industry. Critics praise the stunning visual effects and profound storyline, while fans are already anticipating a third installment.\n\nThe film, shot across three continents over eighteen months, represents a monumental achievement in modern filmmaking. The director\'s vision, combining practical effects with cutting-edge CGI, has set a new standard that competitors will struggle to match.\n\nStreaming rights have already been acquired for a record sum, suggesting the film\'s cultural dominance will continue well beyond its theatrical run.',
    imageUrl:
        'https://images.unsplash.com/photo-1485061614053-539665bc7c47?auto=format&fit=crop&q=80&w=1000',
    category: 'Entertainment',
    date: '2 Days Ago',
    author: 'Vikram Singh',
    readTime: 4,
  ),
];

// ============================================================================
// THEME CONSTANTS
// ============================================================================

class AppColors {
  // Dark editorial palette
  static const bg = Color(0xFF0A0A0F);
  static const surface = Color(0xFF13131A);
  static const surfaceHigh = Color(0xFF1C1C27);
  static const border = Color(0xFF2A2A38);
  static const borderLight = Color(0xFF3A3A4E);

  // Accent — vivid amber/gold for editorial feel
  static const accent = Color(0xFFF5A623);
  static const accentDim = Color(0xFF7A5310);

  // Category chip colors
  static const techColor = Color(0xFF00D4FF);
  static const sportsColor = Color(0xFF00FF88);
  static const politicsColor = Color(0xFFFF6B6B);
  static const entertainColor = Color(0xFFBB86FC);

  static const textPrimary = Color(0xFFF0F0F5);
  static const textSecondary = Color(0xFF9090A8);
  static const textMuted = Color(0xFF555568);
}

Color categoryColor(String cat) {
  switch (cat) {
    case 'Technology':
      return AppColors.techColor;
    case 'Sports':
      return AppColors.sportsColor;
    case 'Politics':
      return AppColors.politicsColor;
    case 'Entertainment':
      return AppColors.entertainColor;
    default:
      return AppColors.accent;
  }
}

// ============================================================================
// APP ROOT
// ============================================================================

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        fontFamily: 'Georgia',
        colorScheme: const ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.accent,
          secondary: AppColors.techColor,
          background: AppColors.bg,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/detail': (context) => const NewsDetailScreen(),
      },
    );
  }
}

// ============================================================================
// SHARED WIDGETS
// ============================================================================

class GlassBox extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const GlassBox({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: child,
    );
  }
}

class PulseButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const PulseButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color = AppColors.accent,
  });

  @override
  State<PulseButton> createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween(begin: 1.0, end: 0.96).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8))
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xFF0A0A0F),
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              fontFamily: 'Courier',
            ),
          ),
        ),
      ),
    );
  }
}

class DarkTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;

  const DarkTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassBox(
      padding: EdgeInsets.zero,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontFamily: 'Courier'),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: AppColors.textMuted, fontSize: 13, fontFamily: 'Courier'),
          prefixIcon: Icon(icon, color: AppColors.accent, size: 20),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}

// ============================================================================
// ANIMATED NOISE / GRID PAINTER  (background decoration)
// ============================================================================

class GridPainter extends CustomPainter {
  final Color color;
  GridPainter({this.color = const Color(0xFF1E1E2A)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    const step = 36.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// 1. SPLASH SCREEN
// ============================================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _slide;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: 30.0, end: 0.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();

    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Grid background
          Positioned.fill(
            child: CustomPaint(painter: GridPainter()),
          ),
          // Glow effect top
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.15),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (context, child) => FadeTransition(
                opacity: _fade,
                child: Transform.translate(
                  offset: Offset(0, _slide.value),
                  child: child,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.4),
                          blurRadius: 40,
                          offset: const Offset(0, 15),
                        )
                      ],
                    ),
                    child: const Icon(Icons.bolt_rounded,
                        color: AppColors.bg, size: 48),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'PULSE',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      letterSpacing: 12,
                      fontFamily: 'Courier',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 220,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.accent,
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'WORLD CLASS JOURNALISM',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      letterSpacing: 4,
                      fontFamily: 'Courier',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. LOGIN SCREEN
// ============================================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailCtrl.text.trim().isEmpty || _passCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(
          'Email aur password required hai!', AppColors.politicsColor));
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          Positioned(
            bottom: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.accent.withOpacity(0.08),
                  Colors.transparent
                ]),
              ),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: AppColors.accent.withOpacity(0.3)),
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome\nBack.',
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        height: 1.1,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Stay ahead of every story.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 52),
                    DarkTextField(
                        controller: _emailCtrl,
                        label: 'Email Address',
                        icon: Icons.alternate_email_rounded),
                    const SizedBox(height: 16),
                    DarkTextField(
                        controller: _passCtrl,
                        label: 'Password',
                        icon: Icons.lock_outline_rounded,
                        obscure: true),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: AppColors.textMuted, fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    PulseButton(label: 'LOGIN', onTap: _login),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(color: AppColors.border, height: 1)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR',
                              style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                  letterSpacing: 2,
                                  fontFamily: 'Courier')),
                        ),
                        Expanded(
                            child: Divider(color: AppColors.border, height: 1)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                      child: GlassBox(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: const Center(
                          child: Text(
                            "Don't have an account?  CREATE ONE →",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Courier',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. SIGNUP SCREEN
// ============================================================================

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _signup() {
    if (_emailCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          _buildSnackBar('Fields empty nahi hone chahiye!', AppColors.politicsColor));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
        _buildSnackBar('Account bana diya! Ab login karo.', AppColors.sportsColor));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.techColor.withOpacity(0.08),
                  Colors.transparent
                ]),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.techColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: AppColors.techColor.withOpacity(0.3)),
                    ),
                    child: const Text(
                      'JOIN NOW',
                      style: TextStyle(
                        color: AppColors.techColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        fontFamily: 'Courier',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Your\nAccount.',
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      height: 1.1,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Be the first to know everything.',
                    style:
                        TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                  const SizedBox(height: 52),
                  DarkTextField(
                      controller: _emailCtrl,
                      label: 'Email Address',
                      icon: Icons.alternate_email_rounded),
                  const SizedBox(height: 16),
                  DarkTextField(
                      controller: _passCtrl,
                      label: 'Password',
                      icon: Icons.lock_outline_rounded,
                      obscure: true),
                  const SizedBox(height: 36),
                  PulseButton(
                      label: 'CREATE ACCOUNT',
                      onTap: _signup,
                      color: AppColors.techColor),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: GlassBox(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: const Center(
                        child: Text(
                          'Already a member?  SIGN IN →',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Courier',
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SNACKBAR HELPER
// ============================================================================

SnackBar _buildSnackBar(String msg, Color color) {
  return SnackBar(
    content: Text(msg,
        style: const TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5)),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(16),
  );
}

// ============================================================================
// 4. HOME SCREEN
// ============================================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _categories = [
    'All',
    'Saved',
    'Technology',
    'Sports',
    'Politics',
    'Entertainment'
  ];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  late AnimationController _listCtrl;

  @override
  void initState() {
    super.initState();
    _listCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _listCtrl.forward();
  }

  @override
  void dispose() {
    _listCtrl.dispose();
    super.dispose();
  }

  List<Article> get _filtered {
    List<Article> temp = List.from(globalArticles);
    if (_selectedCategory == 'Saved') {
      temp = temp.where((a) => a.isBookmarked).toList();
    } else if (_selectedCategory != 'All') {
      temp = temp.where((a) => a.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      temp = temp
          .where((a) =>
              a.title.toLowerCase().contains(q) ||
              a.description.toLowerCase().contains(q))
          .toList();
    }
    return temp;
  }

  void _showAddEdit({Article? article}) {
    final bool isEdit = article != null;
    final titleCtrl = TextEditingController(text: article?.title ?? '');
    final descCtrl = TextEditingController(text: article?.description ?? '');
    final imgCtrl = TextEditingController(
        text: article?.imageUrl ??
            'https://images.unsplash.com/photo-1588681664899-f142ff2dc9b1?auto=format&fit=crop&q=80&w=1000');
    final contentCtrl =
        TextEditingController(text: article?.content ?? 'Article content...');
    String category = article?.category ?? 'Technology';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDs) => Dialog(
          backgroundColor: AppColors.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEdit ? 'EDIT ARTICLE' : 'NEW ARTICLE',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: AppColors.accent,
                      fontFamily: 'Courier',
                    ),
                  ),
                  const SizedBox(height: 24),
                  _dialogField(titleCtrl, 'Title'),
                  const SizedBox(height: 12),
                  _dialogField(descCtrl, 'Short Description'),
                  const SizedBox(height: 12),
                  _dialogField(imgCtrl, 'Image URL'),
                  const SizedBox(height: 12),
                  _dialogField(contentCtrl, 'Content', maxLines: 3),
                  const SizedBox(height: 12),
                  GlassBox(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: ['Technology', 'Sports', 'Politics', 'Entertainment'].contains(category) ? category : 'Technology',
                        dropdownColor: AppColors.surfaceHigh,
                        isExpanded: true,
                        style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontFamily: 'Courier'),
                        items: ['Technology', 'Sports', 'Politics', 'Entertainment']
                            .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(c,
                                    style: TextStyle(
                                        color: categoryColor(c)))))
                            .toList(),
                        onChanged: (val) =>
                            setDs(() => category = val!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel',
                              style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontFamily: 'Courier')),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PulseButton(
                          label: isEdit ? 'SAVE' : 'ADD',
                          onTap: () {
                            if (titleCtrl.text.isEmpty || descCtrl.text.isEmpty) return;
                            setState(() {
                              if (isEdit) {
                                article.title = titleCtrl.text;
                                article.description = descCtrl.text;
                                article.imageUrl = imgCtrl.text;
                                article.content = contentCtrl.text;
                                article.category = category;
                              } else {
                                globalArticles.insert(
                                  0,
                                  Article(
                                    id: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    title: titleCtrl.text,
                                    description: descCtrl.text,
                                    content: contentCtrl.text,
                                    imageUrl: imgCtrl.text,
                                    category: category,
                                    date: 'Just Now',
                                  ),
                                );
                              }
                            });
                            Navigator.pop(ctx);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dialogField(TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return GlassBox(
      padding: EdgeInsets.zero,
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: const TextStyle(
            color: AppColors.textPrimary,
            fontFamily: 'Courier',
            fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  void _deleteArticle(String id) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DELETE?',
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 3,
                    color: AppColors.politicsColor,
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 16),
              const Text(
                  'Yeh article permanently delete ho jaayega. Sure ho?',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel',
                            style: TextStyle(
                                color: AppColors.textMuted,
                                fontFamily: 'Courier'))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PulseButton(
                      label: 'DELETE',
                      color: AppColors.politicsColor,
                      onTap: () {
                        setState(() =>
                            globalArticles.removeWhere((a) => a.id == id));
                        Navigator.pop(ctx);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = _filtered;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PULSE',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                              letterSpacing: 6,
                              fontFamily: 'Courier',
                            ),
                          ),
                          Text(
                            "Today's Stories",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_rounded,
                              color: AppColors.bg, size: 20),
                        ),
                        onPressed: () => _showAddEdit(),
                        tooltip: 'Add Article',
                      ),
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHigh,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(Icons.logout_rounded,
                              color: AppColors.textSecondary, size: 20),
                        ),
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        tooltip: 'Logout',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GlassBox(
                    borderRadius: 14,
                    padding: EdgeInsets.zero,
                    child: TextField(
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontFamily: 'Courier',
                          fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search karo articles mein...',
                        hintStyle: const TextStyle(
                            color: AppColors.textMuted, fontSize: 14),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: AppColors.accent, size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Category chips
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    itemBuilder: (_, i) {
                      final cat = _categories[i];
                      final selected = cat == _selectedCategory;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.accent
                                : AppColors.surfaceHigh,
                            borderRadius: BorderRadius.circular(21),
                            border: Border.all(
                              color: selected
                                  ? AppColors.accent
                                  : AppColors.border,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (cat == 'Saved')
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Icon(Icons.bookmark_rounded,
                                      size: 13,
                                      color: selected
                                          ? AppColors.bg
                                          : AppColors.accent),
                                ),
                              Text(
                                cat,
                                style: TextStyle(
                                  color: selected
                                      ? AppColors.bg
                                      : AppColors.textSecondary,
                                  fontWeight: selected
                                      ? FontWeight.w900
                                      : FontWeight.w500,
                                  fontSize: 13,
                                  fontFamily: 'Courier',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Articles
                Expanded(
                  child: articles.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.search_off_rounded,
                                  size: 60, color: AppColors.textMuted),
                              const SizedBox(height: 16),
                              Text('Koi article nahi mila.',
                                  style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontFamily: 'Courier',
                                      fontSize: 14)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return _ArticleCard(
                              article: articles[index],
                              index: index,
                              onEdit: () => _showAddEdit(article: articles[index]),
                              onDelete: () => _deleteArticle(articles[index].id),
                              onBookmark: () =>
                                  setState(() => articles[index].isBookmarked =
                                      !articles[index].isBookmarked),
                              onTap: () => Navigator.pushNamed(context, '/detail',
                                      arguments: articles[index])
                                  .then((_) => setState(() {})),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ARTICLE CARD WIDGET
// ============================================================================

class _ArticleCard extends StatefulWidget {
  final Article article;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onBookmark;
  final VoidCallback onTap;

  const _ArticleCard({
    required this.article,
    required this.index,
    required this.onEdit,
    required this.onDelete,
    required this.onBookmark,
    required this.onTap,
  });

  @override
  State<_ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<_ArticleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
            begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final catColor = categoryColor(article.category);

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(19)),
                    child: Hero(
                      tag: 'img_${article.id}',
                      child: Stack(
                        children: [
                          Image.network(
                            article.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 200,
                              color: AppColors.surfaceHigh,
                              child: const Icon(Icons.image_not_supported_rounded,
                                  size: 48, color: AppColors.textMuted),
                            ),
                          ),
                          // Category badge on image
                          Positioned(
                            top: 14,
                            left: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.bg.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: catColor.withOpacity(0.4)),
                              ),
                              child: Text(
                                article.category.toUpperCase(),
                                style: TextStyle(
                                  color: catColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontFamily: 'Courier',
                                ),
                              ),
                            ),
                          ),
                          // Read time badge
                          Positioned(
                            top: 14,
                            right: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.bg.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${article.readTime} min',
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 10,
                                  fontFamily: 'Courier',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                            height: 1.2,
                            letterSpacing: -0.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          article.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),

                        // Left accent line
                        Container(
                          height: 1,
                          color: AppColors.border,
                        ),
                        const SizedBox(height: 14),

                        Row(
                          children: [
                            // Author dot
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: catColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  article.author[0].toUpperCase(),
                                  style: TextStyle(
                                    color: catColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.author,
                                    style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    article.date,
                                    style: const TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            // Bookmark
                            GestureDetector(
                              onTap: widget.onBookmark,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: article.isBookmarked
                                      ? AppColors.accent.withOpacity(0.15)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  article.isBookmarked
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  color: article.isBookmarked
                                      ? AppColors.accent
                                      : AppColors.textMuted,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            // More menu
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert_rounded,
                                  color: AppColors.textMuted, size: 20),
                              color: AppColors.surfaceHigh,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side:
                                      const BorderSide(color: AppColors.border)),
                              onSelected: (v) {
                                if (v == 'edit') widget.onEdit();
                                if (v == 'delete') widget.onDelete();
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(children: [
                                    Icon(Icons.edit_outlined,
                                        size: 16, color: AppColors.textSecondary),
                                    SizedBox(width: 10),
                                    Text('Edit',
                                        style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontFamily: 'Courier'))
                                  ]),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(children: [
                                    Icon(Icons.delete_outline_rounded,
                                        size: 16, color: AppColors.politicsColor),
                                    SizedBox(width: 10),
                                    Text('Delete',
                                        style: TextStyle(
                                            color: AppColors.politicsColor,
                                            fontFamily: 'Courier'))
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        ),
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
}

// ============================================================================
// 5. NEWS DETAIL SCREEN
// ============================================================================

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Article? article =
        ModalRoute.of(context)?.settings.arguments as Article?;
    if (article == null) {
      return Scaffold(
          backgroundColor: AppColors.bg,
          body: const Center(
              child: Text('Article nahi mila.',
                  style: TextStyle(color: AppColors.textSecondary))));
    }

    final catColor = categoryColor(article.category);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero image app bar
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppColors.bg,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.bg.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.arrow_back_rounded,
                      color: AppColors.textPrimary, size: 18),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () =>
                      setState(() => article.isBookmarked = !article.isBookmarked),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: article.isBookmarked
                          ? AppColors.accent.withOpacity(0.2)
                          : AppColors.bg.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: article.isBookmarked
                              ? AppColors.accent
                              : AppColors.border),
                    ),
                    child: Icon(
                      article.isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: article.isBookmarked
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'img_${article.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceHigh,
                          child: const Icon(Icons.broken_image,
                              size: 60, color: AppColors.textMuted)),
                    ),
                    // Bottom fade
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.bg.withOpacity(0.9),
                          ],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fade,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category + time row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: catColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: catColor.withOpacity(0.3)),
                          ),
                          child: Text(
                            article.category.toUpperCase(),
                            style: TextStyle(
                              color: catColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: 'Courier',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHigh,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.schedule_rounded,
                                  size: 11, color: AppColors.textMuted),
                              const SizedBox(width: 4),
                              Text(
                                '${article.readTime} min read',
                                style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 10,
                                    fontFamily: 'Courier'),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(article.date,
                            style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 12,
                                fontFamily: 'Courier')),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Author row
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: catColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              article.author[0].toUpperCase(),
                              style: TextStyle(
                                color: catColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.author,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                )),
                            const Text('Staff Reporter',
                                style: TextStyle(
                                    color: AppColors.textMuted, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Divider with accent
                    Row(
                      children: [
                        Container(
                            width: 4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: catColor,
                              borderRadius: BorderRadius.circular(2),
                            )),
                        const SizedBox(width: 12),
                        const Expanded(
                            child: Divider(color: AppColors.border, height: 1)),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Description (pull quote style)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        // Left accent
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: catColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              article.description,
                              style: const TextStyle(
                                fontSize: 17,
                                color: AppColors.textPrimary,
                                fontStyle: FontStyle.italic,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Full content
                    ...article.content.split('\n\n').where((p) => p.isNotEmpty).map(
                      (paragraph) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          paragraph,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            height: 1.85,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Footer tag
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceHigh,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          '— END OF ARTICLE —',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10,
                            letterSpacing: 3,
                            fontFamily: 'Courier',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
