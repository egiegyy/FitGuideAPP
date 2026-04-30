import 'package:fitguide/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLocale { id, en }

class AppLanguageController extends ChangeNotifier {
  AppLanguageController._();

  static final AppLanguageController instance = AppLanguageController._();
  static const _storageKey = 'fitguide_language';

  AppLocale _locale = AppLocale.id;

  AppLocale get locale => _locale;
  bool get isIndonesian => _locale == AppLocale.id;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_storageKey);
    _locale = code == AppLocale.en.name ? AppLocale.en : AppLocale.id;
  }

  Future<void> setLocale(AppLocale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, locale.name);
    notifyListeners();
  }

  String text(String key) {
    if (_locale == AppLocale.en) return _english[key] ?? key;
    return _indonesian[key] ?? key;
  }

  String format(String key, Map<String, String> values) {
    var result = text(key);
    values.forEach((name, value) {
      result = result.replaceAll('{$name}', value);
    });
    return result;
  }
}

extension AppLanguageContext on BuildContext {
  AppLanguageController get language => AppLanguageController.instance;

  String tr(String key, [Map<String, String> values = const {}]) {
    return AppLanguageController.instance.format(key, values);
  }
}

extension ExerciseLanguage on Exercise {
  String displayName(BuildContext context) => context.tr(name);
  String displayEquipment(BuildContext context) => context.tr(equipment);
  String displayCategory(BuildContext context) => context.tr(category);
  String displayLevel(BuildContext context) => context.tr(level);
  String displayReps(BuildContext context) => context.tr(reps);
  String displayDescription(BuildContext context) => context.tr(description);

  List<String> displaySteps(BuildContext context) {
    return steps.map(context.tr).toList();
  }
}

const Map<String, String> _english = {
  'add_exercise_exists': '{exercise} already exists in {day}',
  'add_exercise_success': '{exercise} added to {day}',
  'greeting': 'Hello {username},',
  'progress_entry_subtitle': '{weight} kg - {reps} reps',
  'FitGuide belum bisa dijalankan di platform ini.':
      'FitGuide cannot run on this platform yet.',
  'Aplikasi Android tetap bisa dipakai seperti biasa. Untuk web, konfigurasi Firebase perlu ditambahkan lebih dulu.':
      'The Android app can still be used as usual. For web, Firebase configuration needs to be added first.',
  'Home': 'Home',
  'Workout': 'Workout',
  'Scanner': 'Scanner',
  'Profile': 'Profile',
  'Sign In': 'Sign In',
  'Sign Up': 'Sign Up',
  'Email': 'Email',
  'Password': 'Password',
  'Username': 'Username',
  'Confirm Password': 'Confirm Password',
  'New Password (Optional)': 'New Password (Optional)',
  'Save Changes': 'Save Changes',
  'Email cannot be empty': 'Email cannot be empty',
  'Email is not valid': 'Email is not valid',
  'Password cannot be empty': 'Password cannot be empty',
  'Password must be at least 6 characters':
      'Password must be at least 6 characters',
  'Username cannot be empty': 'Username cannot be empty',
  'Confirm password cannot be empty': 'Confirm password cannot be empty',
  'Password does not match': 'Password does not match',
  "Don't have account? ": "Don't have account? ",
  'Already have account? ': 'Already have account? ',
  'Email atau password salah': 'Incorrect email or password',
  'Akun tidak ditemukan': 'Account not found',
  'Password salah': 'Incorrect password',
  'Terjadi kesalahan saat login': 'An error occurred while signing in',
  'Terjadi kesalahan saat login Google':
      'An error occurred while signing in with Google',
  'Registrasi berhasil. Silakan masuk untuk melanjutkan.':
      'Registration successful. Please sign in to continue.',
  'Registrasi gagal': 'Registration failed',
  'Email sudah digunakan': 'Email is already in use',
  'Password terlalu lemah': 'Password is too weak',
  'Terjadi kesalahan saat registrasi':
      'An error occurred during registration',
  'Profile updated': 'Profile updated',
  'Failed to update profile': 'Failed to update profile',
  "Let's be better 1% everyday!": "Let's be better 1% everyday!",
  'Your Routine': 'Your Routine',
  'There is no Routine': 'There is no Routine',
  'Add Routine': 'Add Routine',
  'Package Exercise': 'Package Exercise',
  'Push Work out': 'Push Workout',
  'Pull Workout': 'Pull Workout',
  'Push Pull Leg is a workout split that groups exercises based on movement patterns.':
      'Push Pull Leg is a workout split that groups exercises based on movement patterns.',
  'See More': 'See More',
  'More': 'More',
  'Equipment': 'Equipment',
  'Package': 'Package',
  'Progress': 'Progress',
  'Routine': 'Routine',
  'Edit Profile': 'Edit Profile',
  'Language': 'Language',
  'Language Settings': 'Language Settings',
  'Choose Language': 'Choose Language',
  'Bahasa Indonesia': 'Bahasa Indonesia',
  'English': 'English',
  'Logout': 'Logout',
  'Delete Account': 'Delete Account',
  'Apakah anda yakin ingin keluar?': 'Are you sure you want to log out?',
  'Apakah anda yakin ingin menghapus akun?':
      'Are you sure you want to delete your account?',
  'Tidak': 'No',
  'Ya': 'Yes',
  'Camera': 'Camera',
  'Gallery': 'Gallery',
  'Description': 'Description',
  'How to Use': 'How to Use',
  'Category': 'Category',
  'Level': 'Level',
  'Repetitions': 'Repetitions',
  'Exercise': 'Exercise',
  'Scan Gym Equipment': 'Scan Gym Equipment',
  'Scan the barcode on the gym machine to see workout guidance.':
      'Scan the barcode on the gym machine to see workout guidance.',
  'Start Scan': 'Start Scan',
  'Scan the barcode': 'Scan the barcode',
  'Halaman alat belum tersedia': 'Equipment page is not available yet',
  'Alat tidak ditemukan di FitGuide': 'Equipment not found in FitGuide',
  'All days already have routine': 'All days already have routine',
  'Select Day': 'Select Day',
  'Monday': 'Monday',
  'Tuesday': 'Tuesday',
  'Wednesday': 'Wednesday',
  'Thursday': 'Thursday',
  'Friday': 'Friday',
  'Saturday': 'Saturday',
  'Sunday': 'Sunday',
  'Hapus Exercise': 'Delete Exercise',
  'Apakah anda yakin ingin menghapus exercise ini?':
      'Are you sure you want to delete this exercise?',
  'No Exercise Yet': 'No Exercise Yet',
  'All fields are required': 'All fields are required',
  'Workout saved successfully': 'Workout saved successfully',
  'Workout Progress': 'Workout Progress',
  'Weight (kg)': 'Weight (kg)',
  'Weight': 'Weight',
  'Reps': 'Reps',
  'Save Workout': 'Save Workout',
  'Edit Workout': 'Edit Workout',
  'Cancel': 'Cancel',
  'Save': 'Save',
  'Created by FitGuide': 'Created by FitGuide',
  'Push Workout': 'Push Workout',
  'Leg Workout': 'Leg Workout',
  'Full Body Workout': 'Full Body Workout',
  'Chest Press': 'Chest Press',
  'Close Grip Chest Press': 'Close Grip Chest Press',
  'Wide Grip Lat Pulldown': 'Wide Grip Lat Pulldown',
  'Lat Pulldown': 'Lat Pulldown',
  'Close Grip Lat Pulldown': 'Close Grip Lat Pulldown',
  'Leg Press': 'Leg Press',
  'Leg Press Calf Raise': 'Leg Press Calf Raise',
  'Full Body': 'Full Body',
  'Chest Press Machine': 'Chest Press Machine',
  'Lat Pulldown Machine': 'Lat Pulldown Machine',
  'Leg Press Machine': 'Leg Press Machine',
  'Push': 'Push',
  'Pull': 'Pull',
  'Leg': 'Leg',
  'Beginner': 'Beginner',
  'Intermediate': 'Intermediate',
  'Push / Upper / Full Body': 'Push / Upper / Full Body',
  'Pull / Upper / Full Body': 'Pull / Upper / Full Body',
  'Legs / Lower / Full Body': 'Legs / Lower / Full Body',
  'Legs': 'Legs',
  '3 sets Ã— 10â€“12 reps': '3 sets x 10-12 reps',
  '3â€“4 sets Ã— 8â€“12 reps': '3-4 sets x 8-12 reps',
  '3 sets Ã— 10â€“15 reps': '3 sets x 10-15 reps',
  '3â€“4 sets Ã— 12â€“15 reps': '3-4 sets x 12-15 reps',
  'The Chest Press Machine is a piece of gym equipment that trains the chest muscles by pushing weights forward. This exercise targets the pectoralis major, as well as engaging the anterior shoulders and triceps.':
      'The Chest Press Machine is a piece of gym equipment that trains the chest muscles by pushing weights forward. This exercise targets the pectoralis major, as well as engaging the anterior shoulders and triceps.',
  'A gym tool for training back muscles by pulling a bar from above toward the chest. This exercise helps strengthen and tone the upper back. The main muscles worked are the latissimus dorsi, with assistance from the biceps and rear shoulders.':
      'A gym tool for training back muscles by pulling a bar from above toward the chest. This exercise helps strengthen and tone the upper back. The main muscles worked are the latissimus dorsi, with assistance from the biceps and rear shoulders.',
  'A gym tool for strengthening leg muscles by pushing weights with the legs in a seated or semi-reclining position. This exercise targets the quadriceps as the primary muscle, while also engaging the glutes and hamstrings as supporting muscles.':
      'A gym tool for strengthening leg muscles by pushing weights with the legs in a seated or semi-reclining position. This exercise targets the quadriceps as the primary muscle, while also engaging the glutes and hamstrings as supporting muscles.',
  'The chest press is a fundamental exercise used to train the chest (pectoral), front shoulder (anterior deltoid), and triceps muscles. This machine provides stability, making it ideal for beginners who want to learn pushing movement patterns without needing to balance weights like with a barbell or dumbbell.':
      'The chest press is a fundamental exercise used to train the chest (pectoral), front shoulder (anterior deltoid), and triceps muscles. This machine provides stability, making it ideal for beginners who want to learn pushing movement patterns without needing to balance weights like with a barbell or dumbbell.',
  'The close grip chest press variation uses a narrower hand position to increase focus on the triceps and inner chest muscles. This movement is suitable for users who are already familiar with the standard chest press and want to add variation to their pushing workouts.':
      'The close grip chest press variation uses a narrower hand position to increase focus on the triceps and inner chest muscles. This movement is suitable for users who are already familiar with the standard chest press and want to add variation to their pushing workouts.',
  'The wide grip lat pulldown targets the back muscles, especially the latissimus dorsi, while also engaging the shoulders and biceps as supporting muscles. This movement mimics the pull-up pattern but with adjustable resistance, making it suitable for beginners.':
      'The wide grip lat pulldown targets the back muscles, especially the latissimus dorsi, while also engaging the shoulders and biceps as supporting muscles. This movement mimics the pull-up pattern but with adjustable resistance, making it suitable for beginners.',
  'The close grip lat pulldown uses a narrower grip to place greater emphasis on the middle back and biceps. This variation also increases the range of motion, helping improve muscle control in the back.':
      'The close grip lat pulldown uses a narrower grip to place greater emphasis on the middle back and biceps. This variation also increases the range of motion, helping improve muscle control in the back.',
  'The leg press is a fundamental exercise for training the quadriceps, hamstrings, and glutes. This machine provides high stability, allowing usersâ€”especially beginnersâ€”to lift heavier loads compared to squats.':
      'The leg press is a fundamental exercise for training the quadriceps, hamstrings, and glutes. This machine provides high stability, allowing users, especially beginners, to lift heavier loads compared to squats.',
  'The leg press calf raise is a calf exercise variation performed using a leg press machine. This movement targets the gastrocnemius and soleus muscles, which play an important role in ankle strength and stability.':
      'The leg press calf raise is a calf exercise variation performed using a leg press machine. This movement targets the gastrocnemius and soleus muscles, which play an important role in ankle strength and stability.',
  'Sit on the chest press machine and adjust the seat height so that the handles are aligned with the middle of your chest.':
      'Sit on the chest press machine and adjust the seat height so that the handles are aligned with the middle of your chest.',
  'Keep your back and head against the backrest to maintain a stable posture.':
      'Keep your back and head against the backrest to maintain a stable posture.',
  'Grip the handles with both hands, then push forward until your arms are nearly straight.':
      'Grip the handles with both hands, then push forward until your arms are nearly straight.',
  'Avoid locking your elbows completely to keep your joints safe.':
      'Avoid locking your elbows completely to keep your joints safe.',
  'Slowly return the handles to the starting position while maintaining control.':
      'Slowly return the handles to the starting position while maintaining control.',
  'Repeat the movement with a steady and controlled tempo.':
      'Repeat the movement with a steady and controlled tempo.',
  'Sit on the chest press machine with your back firmly against the backrest.':
      'Sit on the chest press machine with your back firmly against the backrest.',
  'Hold the handles with a grip narrower than shoulder width.':
      'Hold the handles with a grip narrower than shoulder width.',
  'Push the handles forward while keeping your elbows close to your body.':
      'Push the handles forward while keeping your elbows close to your body.',
  'Pause briefly when your arms are nearly straight to maximize muscle contraction.':
      'Pause briefly when your arms are nearly straight to maximize muscle contraction.',
  'Slowly return the handles to the starting position with control.':
      'Slowly return the handles to the starting position with control.',
  'Maintain steady breathing throughout the movement.':
      'Maintain steady breathing throughout the movement.',
  'Sit on the lat pulldown machine and secure your thighs under the pads to prevent your body from lifting.':
      'Sit on the lat pulldown machine and secure your thighs under the pads to prevent your body from lifting.',
  'Grip the bar with your hands wider than shoulder width.':
      'Grip the bar with your hands wider than shoulder width.',
  'Pull the bar down toward your upper chest while keeping your chest open and your back upright.':
      'Pull the bar down toward your upper chest while keeping your chest open and your back upright.',
  'Focus on pulling with your back muscles rather than just your arms.':
      'Focus on pulling with your back muscles rather than just your arms.',
  'Pause briefly when the bar is close to your chest.':
      'Pause briefly when the bar is close to your chest.',
  'Slowly release the bar back to the starting position with control.':
      'Slowly release the bar back to the starting position with control.',
  'Sit on the lat pulldown machine with your thighs secured under the pads.':
      'Sit on the lat pulldown machine with your thighs secured under the pads.',
  'Hold the handle with a narrower grip or use a close-grip attachment.':
      'Hold the handle with a narrower grip or use a close-grip attachment.',
  'Pull the handle down toward your chest while keeping your back upright.':
      'Pull the handle down toward your chest while keeping your back upright.',
  'Ensure your elbows move downward and slightly backward.':
      'Ensure your elbows move downward and slightly backward.',
  'Pause briefly when the handle is near your chest for maximum contraction.':
      'Pause briefly when the handle is near your chest for maximum contraction.',
  'Slowly return the handle to the starting position.':
      'Slowly return the handle to the starting position.',
  'Sit or lie on the leg press machine with your back firmly against the backrest.':
      'Sit or lie on the leg press machine with your back firmly against the backrest.',
  'Place both feet on the platform at shoulder-width distance.':
      'Place both feet on the platform at shoulder-width distance.',
  'Release the safety locks if available.': 'Release the safety locks if available.',
  'Push the platform with your legs until your knees are almost fully extended.':
      'Push the platform with your legs until your knees are almost fully extended.',
  'Do not lock your knees to protect your joints.':
      'Do not lock your knees to protect your joints.',
  'Lower the platform slowly until your knees form approximately a 90-degree angle.':
      'Lower the platform slowly until your knees form approximately a 90-degree angle.',
  'Sit on the leg press machine and place the balls of your feet on the platform.':
      'Sit on the leg press machine and place the balls of your feet on the platform.',
  'Ensure your heels are slightly off the platform to allow full movement.':
      'Ensure your heels are slightly off the platform to allow full movement.',
  'Push the platform using your toes until your heels are lifted.':
      'Push the platform using your toes until your heels are lifted.',
  'Feel the contraction in your calf muscles at the top of the movement.':
      'Feel the contraction in your calf muscles at the top of the movement.',
  'Lower your heels slowly until you feel a stretch in your calves.':
      'Lower your heels slowly until you feel a stretch in your calves.',
};

const Map<String, String> _indonesian = {
  'add_exercise_exists': '{exercise} sudah ada di {day}',
  'add_exercise_success': '{exercise} ditambahkan ke {day}',
  'greeting': 'Halo {username},',
  'progress_entry_subtitle': '{weight} kg - {reps} repetisi',
  'Home': 'Beranda',
  'Workout': 'Latihan',
  'Scanner': 'Pemindai',
  'Profile': 'Profil',
  'Sign In': 'Masuk',
  'Sign Up': 'Daftar',
  'Password': 'Kata Sandi',
  'Username': 'Nama Pengguna',
  'Confirm Password': 'Konfirmasi Kata Sandi',
  'New Password (Optional)': 'Kata Sandi Baru (Opsional)',
  'Save Changes': 'Simpan Perubahan',
  'Email cannot be empty': 'Email tidak boleh kosong',
  'Email is not valid': 'Email tidak valid',
  'Password cannot be empty': 'Kata sandi tidak boleh kosong',
  'Password must be at least 6 characters': 'Kata sandi minimal 6 karakter',
  'Username cannot be empty': 'Nama pengguna tidak boleh kosong',
  'Confirm password cannot be empty':
      'Konfirmasi kata sandi tidak boleh kosong',
  'Password does not match': 'Kata sandi tidak cocok',
  "Don't have account? ": 'Belum punya akun? ',
  'Already have account? ': 'Sudah punya akun? ',
  'Email atau password salah': 'Email atau kata sandi salah',
  'Akun tidak ditemukan': 'Akun tidak ditemukan',
  'Password salah': 'Kata sandi salah',
  'Terjadi kesalahan saat login': 'Terjadi kesalahan saat masuk',
  'Terjadi kesalahan saat login Google':
      'Terjadi kesalahan saat masuk dengan Google',
  'Registrasi berhasil. Silakan masuk untuk melanjutkan.':
      'Registrasi berhasil. Silakan masuk untuk melanjutkan.',
  'Registrasi gagal': 'Registrasi gagal',
  'Email sudah digunakan': 'Email sudah digunakan',
  'Password terlalu lemah': 'Kata sandi terlalu lemah',
  'Terjadi kesalahan saat registrasi':
      'Terjadi kesalahan saat registrasi',
  'Profile updated': 'Profil berhasil diperbarui',
  'Failed to update profile': 'Gagal memperbarui profil',
  "Let's be better 1% everyday!": 'Ayo jadi 1% lebih baik setiap hari!',
  'Your Routine': 'Rutinitas Anda',
  'There is no Routine': 'Belum ada rutinitas',
  'Add Routine': 'Tambah Rutinitas',
  'Package Exercise': 'Paket Latihan',
  'Push Work out': 'Latihan Push',
  'Pull Workout': 'Latihan Pull',
  'Push Pull Leg is a workout split that groups exercises based on movement patterns.':
      'Push Pull Leg adalah pembagian latihan berdasarkan pola gerakan.',
  'See More': 'Lihat Lainnya',
  'More': 'Detail',
  'Equipment': 'Peralatan',
  'Package': 'Paket',
  'Progress': 'Progres',
  'Routine': 'Rutinitas',
  'Edit Profile': 'Edit Profil',
  'Language': 'Bahasa',
  'Language Settings': 'Pengaturan Bahasa',
  'Choose Language': 'Pilih Bahasa',
  'Logout': 'Keluar',
  'Delete Account': 'Hapus Akun',
  'Apakah anda yakin ingin keluar?': 'Apakah anda yakin ingin keluar?',
  'Apakah anda yakin ingin menghapus akun?':
      'Apakah anda yakin ingin menghapus akun?',
  'Tidak': 'Tidak',
  'Ya': 'Ya',
  'Camera': 'Kamera',
  'Gallery': 'Galeri',
  'Description': 'Deskripsi',
  'How to Use': 'Cara Menggunakan',
  'Category': 'Kategori',
  'Level': 'Level',
  'Repetitions': 'Repetisi',
  'Exercise': 'Latihan',
  'Scan Gym Equipment': 'Pindai Peralatan Gym',
  'Scan the barcode on the gym machine to see workout guidance.':
      'Pindai barcode pada mesin gym untuk melihat panduan latihan.',
  'Start Scan': 'Mulai Pindai',
  'Scan the barcode': 'Pindai barcode',
  'Halaman alat belum tersedia': 'Halaman alat belum tersedia',
  'Alat tidak ditemukan di FitGuide': 'Alat tidak ditemukan di FitGuide',
  'All days already have routine': 'Semua hari sudah memiliki rutinitas',
  'Select Day': 'Pilih Hari',
  'Monday': 'Senin',
  'Tuesday': 'Selasa',
  'Wednesday': 'Rabu',
  'Thursday': 'Kamis',
  'Friday': 'Jumat',
  'Saturday': 'Sabtu',
  'Sunday': 'Minggu',
  'Hapus Exercise': 'Hapus Latihan',
  'Apakah anda yakin ingin menghapus exercise ini?':
      'Apakah anda yakin ingin menghapus latihan ini?',
  'No Exercise Yet': 'Belum ada latihan',
  'All fields are required': 'Semua kolom wajib diisi',
  'Workout saved successfully': 'Latihan berhasil disimpan',
  'Workout Progress': 'Progres Latihan',
  'Weight (kg)': 'Berat (kg)',
  'Weight': 'Berat',
  'Reps': 'Repetisi',
  'Save Workout': 'Simpan Latihan',
  'Edit Workout': 'Edit Latihan',
  'Cancel': 'Batal',
  'Save': 'Simpan',
  'Created by FitGuide': 'Dibuat oleh FitGuide',
  'Push Workout': 'Latihan Push',
  'Leg Workout': 'Latihan Kaki',
  'Full Body Workout': 'Latihan Seluruh Tubuh',
  'Chest Press': 'Chest Press',
  'Close Grip Chest Press': 'Close Grip Chest Press',
  'Wide Grip Lat Pulldown': 'Wide Grip Lat Pulldown',
  'Lat Pulldown': 'Lat Pulldown',
  'Close Grip Lat Pulldown': 'Close Grip Lat Pulldown',
  'Leg Press': 'Leg Press',
  'Leg Press Calf Raise': 'Leg Press Calf Raise',
  'Full Body': 'Seluruh Tubuh',
  'Chest Press Machine': 'Mesin Chest Press',
  'Lat Pulldown Machine': 'Mesin Lat Pulldown',
  'Leg Press Machine': 'Mesin Leg Press',
  'Push': 'Push',
  'Pull': 'Pull',
  'Leg': 'Kaki',
  'Beginner': 'Pemula',
  'Intermediate': 'Menengah',
  'Push / Upper / Full Body': 'Push / Tubuh Atas / Seluruh Tubuh',
  'Pull / Upper / Full Body': 'Pull / Tubuh Atas / Seluruh Tubuh',
  'Legs / Lower / Full Body': 'Kaki / Tubuh Bawah / Seluruh Tubuh',
  'Legs': 'Kaki',
  '3 sets Ã— 10â€“12 reps': '3 set x 10-12 repetisi',
  '3â€“4 sets Ã— 8â€“12 reps': '3-4 set x 8-12 repetisi',
  '3 sets Ã— 10â€“15 reps': '3 set x 10-15 repetisi',
  '3â€“4 sets Ã— 12â€“15 reps': '3-4 set x 12-15 repetisi',
  'The Chest Press Machine is a piece of gym equipment that trains the chest muscles by pushing weights forward. This exercise targets the pectoralis major, as well as engaging the anterior shoulders and triceps.':
      'Mesin Chest Press adalah alat gym untuk melatih otot dada dengan mendorong beban ke depan. Latihan ini menargetkan pectoralis major serta melibatkan bahu depan dan trisep.',
  'A gym tool for training back muscles by pulling a bar from above toward the chest. This exercise helps strengthen and tone the upper back. The main muscles worked are the latissimus dorsi, with assistance from the biceps and rear shoulders.':
      'Alat gym untuk melatih otot punggung dengan menarik bar dari atas ke arah dada. Latihan ini membantu memperkuat punggung atas, terutama latissimus dorsi, dengan bantuan bisep dan bahu belakang.',
  'A gym tool for strengthening leg muscles by pushing weights with the legs in a seated or semi-reclining position. This exercise targets the quadriceps as the primary muscle, while also engaging the glutes and hamstrings as supporting muscles.':
      'Alat gym untuk memperkuat otot kaki dengan mendorong beban menggunakan kaki dalam posisi duduk atau setengah rebah. Latihan ini menargetkan quadriceps, serta melibatkan glutes dan hamstring.',
  'The chest press is a fundamental exercise used to train the chest (pectoral), front shoulder (anterior deltoid), and triceps muscles. This machine provides stability, making it ideal for beginners who want to learn pushing movement patterns without needing to balance weights like with a barbell or dumbbell.':
      'Chest press adalah latihan dasar untuk melatih dada, bahu depan, dan trisep. Mesin ini memberi stabilitas sehingga cocok untuk pemula yang ingin mempelajari pola gerakan mendorong tanpa harus menyeimbangkan beban seperti barbel atau dumbbell.',
  'The close grip chest press variation uses a narrower hand position to increase focus on the triceps and inner chest muscles. This movement is suitable for users who are already familiar with the standard chest press and want to add variation to their pushing workouts.':
      'Variasi close grip chest press memakai posisi tangan lebih sempit untuk lebih menargetkan trisep dan dada bagian dalam. Gerakan ini cocok bagi pengguna yang sudah familiar dengan chest press standar dan ingin menambah variasi latihan push.',
  'The wide grip lat pulldown targets the back muscles, especially the latissimus dorsi, while also engaging the shoulders and biceps as supporting muscles. This movement mimics the pull-up pattern but with adjustable resistance, making it suitable for beginners.':
      'Wide grip lat pulldown menargetkan otot punggung, terutama latissimus dorsi, sambil melibatkan bahu dan bisep sebagai otot pendukung. Gerakan ini meniru pola pull-up dengan beban yang dapat diatur sehingga cocok untuk pemula.',
  'The close grip lat pulldown uses a narrower grip to place greater emphasis on the middle back and biceps. This variation also increases the range of motion, helping improve muscle control in the back.':
      'Close grip lat pulldown memakai pegangan lebih sempit untuk memberi fokus lebih pada punggung tengah dan bisep. Variasi ini juga memperbesar rentang gerak sehingga membantu kontrol otot punggung.',
  'The leg press is a fundamental exercise for training the quadriceps, hamstrings, and glutes. This machine provides high stability, allowing usersâ€”especially beginnersâ€”to lift heavier loads compared to squats.':
      'Leg press adalah latihan dasar untuk melatih quadriceps, hamstring, dan glutes. Mesin ini sangat stabil sehingga pengguna, terutama pemula, dapat mengangkat beban lebih berat dibanding squat.',
  'The leg press calf raise is a calf exercise variation performed using a leg press machine. This movement targets the gastrocnemius and soleus muscles, which play an important role in ankle strength and stability.':
      'Leg press calf raise adalah variasi latihan betis menggunakan mesin leg press. Gerakan ini menargetkan otot gastrocnemius dan soleus yang penting untuk kekuatan serta stabilitas pergelangan kaki.',
  'Sit on the chest press machine and adjust the seat height so that the handles are aligned with the middle of your chest.':
      'Duduk di mesin chest press dan atur tinggi kursi agar handle sejajar dengan bagian tengah dada.',
  'Keep your back and head against the backrest to maintain a stable posture.':
      'Tempelkan punggung dan kepala pada sandaran agar postur tetap stabil.',
  'Grip the handles with both hands, then push forward until your arms are nearly straight.':
      'Pegang handle dengan kedua tangan, lalu dorong ke depan hingga lengan hampir lurus.',
  'Avoid locking your elbows completely to keep your joints safe.':
      'Hindari mengunci siku sepenuhnya agar sendi tetap aman.',
  'Slowly return the handles to the starting position while maintaining control.':
      'Kembalikan handle perlahan ke posisi awal dengan tetap terkontrol.',
  'Repeat the movement with a steady and controlled tempo.':
      'Ulangi gerakan dengan tempo stabil dan terkendali.',
  'Sit on the chest press machine with your back firmly against the backrest.':
      'Duduk di mesin chest press dengan punggung menempel kuat pada sandaran.',
  'Hold the handles with a grip narrower than shoulder width.':
      'Pegang handle dengan jarak lebih sempit dari lebar bahu.',
  'Push the handles forward while keeping your elbows close to your body.':
      'Dorong handle ke depan sambil menjaga siku tetap dekat dengan tubuh.',
  'Pause briefly when your arms are nearly straight to maximize muscle contraction.':
      'Berhenti sejenak saat lengan hampir lurus untuk memaksimalkan kontraksi otot.',
  'Slowly return the handles to the starting position with control.':
      'Kembalikan handle perlahan ke posisi awal dengan kontrol.',
  'Maintain steady breathing throughout the movement.':
      'Jaga napas tetap stabil sepanjang gerakan.',
  'Sit on the lat pulldown machine and secure your thighs under the pads to prevent your body from lifting.':
      'Duduk di mesin lat pulldown dan kunci paha di bawah bantalan agar tubuh tidak terangkat.',
  'Grip the bar with your hands wider than shoulder width.':
      'Pegang bar dengan posisi tangan lebih lebar dari bahu.',
  'Pull the bar down toward your upper chest while keeping your chest open and your back upright.':
      'Tarik bar ke arah dada atas sambil menjaga dada terbuka dan punggung tegak.',
  'Focus on pulling with your back muscles rather than just your arms.':
      'Fokus menarik dengan otot punggung, bukan hanya lengan.',
  'Pause briefly when the bar is close to your chest.':
      'Berhenti sejenak saat bar mendekati dada.',
  'Slowly release the bar back to the starting position with control.':
      'Lepaskan bar perlahan kembali ke posisi awal dengan kontrol.',
  'Sit on the lat pulldown machine with your thighs secured under the pads.':
      'Duduk di mesin lat pulldown dengan paha terkunci di bawah bantalan.',
  'Hold the handle with a narrower grip or use a close-grip attachment.':
      'Pegang handle dengan grip lebih sempit atau gunakan attachment close-grip.',
  'Pull the handle down toward your chest while keeping your back upright.':
      'Tarik handle ke arah dada sambil menjaga punggung tetap tegak.',
  'Ensure your elbows move downward and slightly backward.':
      'Pastikan siku bergerak ke bawah dan sedikit ke belakang.',
  'Pause briefly when the handle is near your chest for maximum contraction.':
      'Berhenti sejenak saat handle dekat dengan dada untuk kontraksi maksimal.',
  'Slowly return the handle to the starting position.':
      'Kembalikan handle perlahan ke posisi awal.',
  'Sit or lie on the leg press machine with your back firmly against the backrest.':
      'Duduk atau berbaring di mesin leg press dengan punggung menempel kuat pada sandaran.',
  'Place both feet on the platform at shoulder-width distance.':
      'Letakkan kedua kaki di platform selebar bahu.',
  'Release the safety locks if available.': 'Lepaskan pengunci keamanan jika tersedia.',
  'Push the platform with your legs until your knees are almost fully extended.':
      'Dorong platform dengan kaki hingga lutut hampir lurus.',
  'Do not lock your knees to protect your joints.':
      'Jangan mengunci lutut agar sendi tetap aman.',
  'Lower the platform slowly until your knees form approximately a 90-degree angle.':
      'Turunkan platform perlahan hingga lutut membentuk sudut sekitar 90 derajat.',
  'Sit on the leg press machine and place the balls of your feet on the platform.':
      'Duduk di mesin leg press dan letakkan bagian depan telapak kaki di platform.',
  'Ensure your heels are slightly off the platform to allow full movement.':
      'Pastikan tumit sedikit keluar dari platform agar gerakan penuh.',
  'Push the platform using your toes until your heels are lifted.':
      'Dorong platform dengan ujung kaki hingga tumit terangkat.',
  'Feel the contraction in your calf muscles at the top of the movement.':
      'Rasakan kontraksi otot betis di puncak gerakan.',
  'Lower your heels slowly until you feel a stretch in your calves.':
      'Turunkan tumit perlahan hingga terasa regangan pada betis.',
};
