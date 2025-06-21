import Foundation

struct QuizQuestion: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswer: Int
}

struct ModuleQuiz {
    let moduleId: Int
    let questions: [QuizQuestion]
}

struct ModuleQuizData {
    static let quizzes: [ModuleQuiz] = [
        ModuleQuiz(moduleId: 1, questions: [
            QuizQuestion(
                text: "What is the primary difference between stress and burnout?",
                options: [
                    "Stress is temporary, burnout is chronic",
                    "Stress is always bad, burnout can be good",
                    "Stress affects only students, burnout affects everyone",
                    "There is no difference between them"
                ],
                correctAnswer: 0
            ),
            QuizQuestion(
                text: "Which is an early warning sign of academic burnout?",
                options: [
                    "Increased motivation",
                    "Chronic exhaustion",
                    "Better sleep patterns",
                    "Improved concentration"
                ],
                correctAnswer: 1
            ),
            // Add more questions for module 1...
        ]),
        ModuleQuiz(moduleId: 2, questions: [
            QuizQuestion(
                text: "Which of the following is NOT a healthy way to manage academic stress?",
                options: [
                    "Taking regular breaks",
                    "Pulling all-nighters regularly",
                    "Exercise and physical activity",
                    "Practicing mindfulness"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Deep breathing exercises primarily help by:",
                options: [
                    "Activating the relaxation response",
                    "Making you fall asleep",
                    "Increasing stress levels",
                    "Improving memory"
                ],
                correctAnswer: 0
            ),
            QuizQuestion(
                text: "What is a key component of building stress resilience?",
                options: [
                    "Avoiding all stressful situations",
                    "Developing healthy coping mechanisms",
                    "Never asking for help",
                    "Working longer hours"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which statement about stress management is true?",
                options: [
                    "Stress should be completely eliminated",
                    "Some stress can be motivating",
                    "Stress is always harmful",
                    "Stress cannot be managed"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "The best time to practice stress management techniques is:",
                options: [
                    "Only during exams",
                    "When you're already overwhelmed",
                    "Regularly, as a preventive measure",
                    "Never, they don't work"
                ],
                correctAnswer: 2
            )
        ]),
        ModuleQuiz(moduleId: 3, questions: [
            QuizQuestion(
                text: "What is the Eisenhower Matrix used for?",
                options: [
                    "Solving mathematical equations",
                    "Prioritizing tasks based on urgency",
                    "Creating study schedules",
                    "Managing social media time"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which of these is a sign of poor time management?",
                options: [
                    "Taking regular breaks",
                    "Using a planner",
                    "Consistently missing deadlines",
                    "Setting specific goals"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "What is the '2-Minute Rule' in time management?",
                options: [
                    "Take a 2-minute break every hour",
                    "If a task takes under 2 minutes, do it now",
                    "Study for 2 minutes at a time",
                    "Check email every 2 minutes"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which strategy helps prevent procrastination?",
                options: [
                    "Waiting for motivation",
                    "Breaking tasks into smaller chunks",
                    "Working only when you feel like it",
                    "Multitasking constantly"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "What is the best approach to creating a study schedule?",
                options: [
                    "Plan every minute of the day",
                    "Study whenever you have free time",
                    "Include buffer time for unexpected events",
                    "Schedule study sessions late at night"
                ],
                correctAnswer: 2
            )
        ]),
        ModuleQuiz(moduleId: 4, questions: [
            QuizQuestion(
                text: "What is the Pomodoro Technique?",
                options: [
                    "A type of pasta sauce",
                    "A 25-minute work session with a break",
                    "A meditation practice",
                    "A way to organize your desk"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which environment is most conducive to focused study?",
                options: [
                    "A noisy café with lots of activity",
                    "Your bed with comfortable pillows",
                    "A quiet, well-lit space with minimal distractions",
                    "A room with TV playing in the background"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "What is 'context switching' and why is it harmful?",
                options: [
                    "Changing study locations - it helps concentration",
                    "Rapidly switching between different tasks - it reduces productivity",
                    "Switching subjects every hour - it improves learning",
                    "Changing study groups - it builds social skills"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which practice can help improve focus during study sessions?",
                options: [
                    "Keeping your phone nearby for emergencies",
                    "Studying in short, focused intervals",
                    "Working on multiple tasks simultaneously",
                    "Skipping breaks to finish faster"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "What is the '5-4-3-2-1' technique used for?",
                options: [
                    "Counting down before an exam",
                    "Organizing study materials",
                    "Reduces anxiety and improves concentration",
                    "Setting daily goals"
                ],
                correctAnswer: 2
            )
        ]),
        ModuleQuiz(moduleId: 5, questions: [
            QuizQuestion(
                text: "What is emotional intelligence?",
                options: [
                    "Being happy all the time",
                    "The ability to understand and manage emotions",
                    "Never showing emotions",
                    "Being emotionally distant"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which practice can help build self-compassion?",
                options: [
                    "Being overly critical of mistakes",
                    "Comparing yourself to others",
                    "Treating yourself with the same kindness you'd show a friend",
                    "Ignoring negative emotions"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "What is a healthy way to deal with academic setbacks?",
                options: [
                    "Viewing them as learning opportunities",
                    "Giving up on the subject",
                    "Hiding them from others",
                    "Blaming yourself completely"
                ],
                correctAnswer: 0
            ),
            QuizQuestion(
                text: "Which statement about self-doubt is most accurate?",
                options: [
                    "It's unique to unsuccessful students",
                    "It's a normal experience that everyone faces",
                    "It should be completely eliminated",
                    "It means you're not capable"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "What is the best approach to managing academic anxiety?",
                options: [
                    "Avoiding all stressful situations",
                    "Pretending it doesn't exist",
                    "Using healthy coping strategies and seeking support",
                    "Working harder and longer"
                ],
                correctAnswer: 2
            )
        ]),
        ModuleQuiz(moduleId: 6, questions: [
            QuizQuestion(
                text: "What is a key component of building a sustainable habit?",
                options: [
                    "Making drastic changes overnight",
                    "Starting with small, manageable steps",
                    "Setting unrealistic goals",
                    "Comparing yourself to others"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "How long does it typically take to form a new habit?",
                options: [
                    "1-2 days",
                    "1 week",
                    "21-66 days on average",
                    "Exactly 30 days"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "Which approach is most effective for maintaining healthy sleep habits?",
                options: [
                    "Varying your sleep schedule each day",
                    "Catching up on sleep on weekends",
                    "Maintaining a consistent sleep schedule",
                    "Studying late into the night"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "What is 'habit stacking'?",
                options: [
                    "Trying to form multiple habits at once",
                    "Linking a new habit to an existing one",
                    "Breaking bad habits",
                    "Writing down your habits"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which statement about healthy habits is most accurate?",
                options: [
                    "They require perfect execution every time",
                    "They should be formed all at once",
                    "Small setbacks don't negate overall progress",
                    "They only work for motivated people"
                ],
                correctAnswer: 2
            )
        ]),
        ModuleQuiz(moduleId: 7, questions: [
            QuizQuestion(
                text: "What does the 'S' in SMART goals stand for?",
                options: [
                    "Simple",
                    "Specific",
                    "Special",
                    "Strategic"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which is an example of a well-defined academic goal?",
                options: [
                    "Do better in school",
                    "Study more",
                    "Complete 2 practice problems daily for calculus",
                    "Get good grades"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "What is the benefit of breaking down long-term goals?",
                options: [
                    "It makes goals seem more overwhelming",
                    "It creates more work",
                    "It makes progress measurable and manageable",
                    "It reduces the importance of the goal"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "How often should you review and adjust your goals?",
                options: [
                    "Never - stick to the original plan",
                    "Only when you fail",
                    "Regularly, at scheduled intervals",
                    "Only at the end of the semester"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "What is a key component of successful goal achievement?",
                options: [
                    "Setting only easy goals",
                    "Never sharing your goals with others",
                    "Having an accountability system",
                    "Avoiding all obstacles"
                ],
                correctAnswer: 2
            )
        ]),
        ModuleQuiz(moduleId: 8, questions: [
            QuizQuestion(
                text: "Why is having a support system important for academic success?",
                options: [
                    "It makes studying more fun",
                    "It provides different perspectives and resources",
                    "It means others will do your work",
                    "It's only important for struggling students"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "What is the best way to approach asking for help from professors?",
                options: [
                    "Wait until you're failing the course",
                    "Send a detailed email explaining your concerns",
                    "Have your parents contact them",
                    "Avoid asking for help to seem capable"
                ],
                correctAnswer: 1
            ),
            QuizQuestion(
                text: "Which is an effective way to build a peer study group?",
                options: [
                    "Only include your friends",
                    "Let others do most of the work",
                    "Set clear goals and expectations",
                    "Meet only when exams are coming"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "What role should academic advisors play in your education?",
                options: [
                    "Fix all your problems",
                    "Only help with course registration",
                    "Guide you through academic challenges and opportunities",
                    "Write your papers"
                ],
                correctAnswer: 2
            ),
            QuizQuestion(
                text: "When is the best time to start building your support network?",
                options: [
                    "When you're already struggling",
                    "At the beginning of your academic journey",
                    "Only during exam periods",
                    "After you've failed a course"
                ],
                correctAnswer: 1
            )
        ])
    ]
    
    static func getQuiz(for moduleId: Int) -> ModuleQuiz? {
        return quizzes.first { $0.moduleId == moduleId }
    }
} 
