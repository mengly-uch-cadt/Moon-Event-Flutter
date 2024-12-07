// import 'package:moon_event/model/event.dart';

// List<Event> dummyEvents = [
//   Event(
//     title: "Fintech Conference 2024",
//     description: "An exciting conference on the future of Fintech.",
//     date: DateTime(2024, 12, 10),
//     time: "10:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "1", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "JSv2GoLB3AX2bu7PHtkTe22o7LF3", "VCYZdLohGbU2vqtd5yRPZTTPXln1"],
//     isPublic: true,
//     categoryId: "0a45f0e6-61bb-40f9-9ce6-c5f7c1f941dc",
//   ),
//   Event(
//     title: "AI & Machine Learning Summit",
//     description: "Dive deep into AI technologies and trends.",
//     date: DateTime(2024, 12, 15),
//     time: "9:00 AM",
//     location: "New York, NY",
//     imageUrl: "2", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["dYDsm4Vogjc4LWLGMaSZCIufQux1", "iP8HPYBpQnWIfS3m98jZLZ3MNmW2", "m18RsrYElTR0tTjyaiuevIIAUjf2"],
//     isPublic: false,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "Cyber Security Forum",
//     description: "Experts discuss the latest in cybersecurity.",
//     date: DateTime(2024, 12, 12),
//     time: "1:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "3", // Image URL between 1 and 46
//     organizerId: "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: true,
//     categoryId: "268614b1-fd0b-4b33-a24d-6162d4df0886",
//   ),
//   Event(
//     title: "Data Science Innovation Day",
//     description: "Join industry experts discussing the latest breakthroughs in Data Science.",
//     date: DateTime(2024, 12, 20),
//     time: "11:00 AM",
//     location: "Chicago, IL",
//     imageUrl: "4", // Image URL between 1 and 46
//     organizerId: "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "CqPG0YgwBzaUgDQaTIE6DdToXHZ2"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "UI/UX Design Trends",
//     description: "A workshop on the latest UI/UX design trends and best practices.",
//     date: DateTime(2024, 12, 18),
//     time: "2:00 PM",
//     location: "Austin, TX",
//     imageUrl: "5", // Image URL between 1 and 46
//     organizerId: "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: false,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Blockchain Development Conference",
//     description: "Everything you need to know about the future of Blockchain development.",
//     date: DateTime(2024, 12, 14),
//     time: "9:30 AM",
//     location: "Dallas, TX",
//     imageUrl: "6", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "dYDsm4Vogjc4LWLGMaSZCIufQux1"],
//     isPublic: true,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Digital Marketing Strategies 2024",
//     description: "Explore cutting-edge strategies in Digital Marketing.",
//     date: DateTime(2024, 12, 17),
//     time: "10:00 AM",
//     location: "Miami, FL",
//     imageUrl: "7", // Image URL between 1 and 46
//     organizerId: "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     participants: ["qmqllcFjVPgHc0MV4Q4PfehF3hL2", "VCYZdLohGbU2vqtd5yRPZTTPXln1"],
//     isPublic: true,
//     categoryId: "e0359913-2024-447a-bfd2-edff6a9a0728",
//   ),
//   Event(
//     title: "Web Development Masterclass",
//     description: "An in-depth class covering advanced Web Development techniques.",
//     date: DateTime(2024, 12, 21),
//     time: "12:00 PM",
//     location: "San Jose, CA",
//     imageUrl: "8", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "iP8HPYBpQnWIfS3m98jZLZ3MNmW2"],
//     isPublic: false,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Tech Trends 2024",
//     description: "Join us for a deep dive into the top tech trends of 2024.",
//     date: DateTime(2024, 12, 13),
//     time: "3:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "9", // Image URL between 1 and 46
//     organizerId: "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     participants: ["dYDsm4Vogjc4LWLGMaSZCIufQux1", "JSv2GoLB3AX2bu7PHtkTe22o7LF3"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "Mobile App Development Workshop",
//     description: "Learn the fundamentals of mobile app development in this hands-on workshop.",
//     date: DateTime(2024, 12, 19),
//     time: "10:30 AM",
//     location: "Chicago, IL",
//     imageUrl: "10", // Image URL between 1 and 46
//     organizerId: "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "VCYZdLohGbU2vqtd5yRPZTTPXln1"],
//     isPublic: false,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Smart City Innovations",
//     description: "A forum on innovations transforming urban life in the age of technology.",
//     date: DateTime(2024, 12, 11),
//     time: "11:30 AM",
//     location: "San Francisco, CA",
//     imageUrl: "11", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["qmqllcFjVPgHc0MV4Q4PfehF3hL2", "iP8HPYBpQnWIfS3m98jZLZ3MNmW2"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "AI Ethics in 2024",
//     description: "A panel discussion on the ethics of AI and machine learning.",
//     date: DateTime(2024, 12, 16),
//     time: "3:30 PM",
//     location: "New York, NY",
//     imageUrl: "12", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "dYDsm4Vogjc4LWLGMaSZCIufQux1"],
//     isPublic: false,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "UI/UX Design Thinking",
//     description: "A session on the principles of design thinking for UI/UX.",
//     date: DateTime(2024, 12, 23),
//     time: "10:00 AM",
//     location: "Austin, TX",
//     imageUrl: "13", // Image URL between 1 and 46
//     organizerId: "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "AqsauIfPHxajYR20eiqGHxyDWxl1"],
//     isPublic: true,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Fintech Innovations and Trends",
//     description: "Discuss the latest innovations and trends in the fintech sector.",
//     date: DateTime(2024, 12, 24),
//     time: "1:00 PM",
//     location: "San Francisco, CA",
//     imageUrl: "14", // Image URL between 1 and 46
//     organizerId: "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: true,
//     categoryId: "0a45f0e6-61bb-40f9-9ce6-c5f7c1f941dc",
//   ),
//   Event(
//     title: "Artificial Intelligence and Automation",
//     description: "Explore how AI is revolutionizing automation in various industries.",
//     date: DateTime(2024, 12, 25),
//     time: "10:00 AM",
//     location: "Chicago, IL",
//     imageUrl: "15", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "dYDsm4Vogjc4LWLGMaSZCIufQux1"],
//     isPublic: false,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "Web Development for 2024",
//     description: "Join experts as they discuss the latest web development technologies and trends.",
//     date: DateTime(2024, 12, 26),
//     time: "12:30 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "16", // Image URL between 1 and 46
//     organizerId: "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "VCYZdLohGbU2vqtd5yRPZTTPXln1"],
//     isPublic: true,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Cyber Security: Protecting Data in 2024",
//     description: "A deep dive into the latest cybersecurity practices and tools.",
//     date: DateTime(2024, 12, 27),
//     time: "11:00 AM",
//     location: "New York, NY",
//     imageUrl: "17", // Image URL between 1 and 46
//     organizerId: "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: false,
//     categoryId: "268614b1-fd0b-4b33-a24d-6162d4df0886",
//   ),
//   Event(
//     title: "Exploring Data Science Careers",
//     description: "An insightful discussion about building a career in data science.",
//     date: DateTime(2024, 12, 28),
//     time: "2:00 PM",
//     location: "San Francisco, CA",
//     imageUrl: "18", // Image URL between 1 and 46
//     organizerId: "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "JSv2GoLB3AX2bu7PHtkTe22o7LF3"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "UI/UX Design in the Digital Age",
//     description: "Learn about the new trends and principles of UI/UX design in modern tech.",
//     date: DateTime(2024, 12, 29),
//     time: "1:30 PM",
//     location: "Austin, TX",
//     imageUrl: "19", // Image URL between 1 and 46
//     organizerId: "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "CqPG0YgwBzaUgDQaTIE6DdToXHZ2"],
//     isPublic: false,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Digital Marketing Future Outlook",
//     description: "A forum discussing what lies ahead for digital marketing in the next decade.",
//     date: DateTime(2024, 12, 30),
//     time: "10:00 AM",
//     location: "Chicago, IL",
//     imageUrl: "20", // Image URL between 1 and 46
//     organizerId: "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "m18RsrYElTR0tTjyaiuevIIAUjf2"],
//     isPublic: true,
//     categoryId: "e0359913-2024-447a-bfd2-edff6a9a0728",
//   ),
//   Event(
//     title: "Blockchain 2024: What’s Next?",
//     description: "Join the discussion on what the future holds for blockchain technologies.",
//     date: DateTime(2024, 12, 31),
//     time: "3:00 PM",
//     location: "San Jose, CA",
//     imageUrl: "21", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: true,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "AI in Business: Opportunities & Challenges",
//     description: "An event to explore how AI is transforming the business landscape.",
//     date: DateTime(2025, 1, 2),
//     time: "11:00 AM",
//     location: "Miami, FL",
//     imageUrl: "22", // Image URL between 1 and 46
//     organizerId: "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "JSv2GoLB3AX2bu7PHtkTe22o7LF3"],
//     isPublic: false,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "Future of Web Development",
//     description: "A session covering the newest technologies in web development.",
//     date: DateTime(2025, 1, 3),
//     time: "1:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "23", // Image URL between 1 and 46
//     organizerId: "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: true,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Cyber Security Risk Management",
//     description: "A hands-on workshop on risk management in cybersecurity.",
//     date: DateTime(2025, 1, 4),
//     time: "9:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "24", // Image URL between 1 and 46
//     organizerId: "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "JSv2GoLB3AX2bu7PHtkTe22o7LF3"],
//     isPublic: false,
//     categoryId: "268614b1-fd0b-4b33-a24d-6162d4df0886",
//   ),
//   Event(
//     title: "AI for Beginners",
//     description: "An introductory workshop for those interested in AI and machine learning.",
//     date: DateTime(2025, 1, 5),
//     time: "2:30 PM",
//     location: "Chicago, IL",
//     imageUrl: "25", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "iP8HPYBpQnWIfS3m98jZLZ3MNmW2"],
//     isPublic: true,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "UI/UX for Mobile Apps",
//     description: "Learn how to design seamless UI/UX for mobile applications.",
//     date: DateTime(2025, 1, 6),
//     time: "10:00 AM",
//     location: "Austin, TX",
//     imageUrl: "26", // Image URL between 1 and 46
//     organizerId: "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     participants: ["qmqllcFjVPgHc0MV4Q4PfehF3hL2", "AqsauIfPHxajYR20eiqGHxyDWxl1"],
//     isPublic: false,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Data Science for Business Leaders",
//     description: "A session focusing on how business leaders can use data science in decision making.",
//     date: DateTime(2025, 1, 7),
//     time: "1:00 PM",
//     location: "New York, NY",
//     imageUrl: "27", // Image URL between 1 and 46
//     organizerId: "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "dYDsm4Vogjc4LWLGMaSZCIufQux1"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "Building the Future of Digital Marketing",
//     description: "A panel discussing the tools and strategies for digital marketing in the future.",
//     date: DateTime(2025, 1, 8),
//     time: "11:30 AM",
//     location: "Miami, FL",
//     imageUrl: "28", // Image URL between 1 and 46
//     organizerId: "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: false,
//     categoryId: "e0359913-2024-447a-bfd2-edff6a9a0728",
//   ),
//   Event(
//     title: "Blockchain and Crypto Investment",
//     description: "Join the experts as they discuss how to invest wisely in blockchain and cryptocurrency.",
//     date: DateTime(2025, 1, 9),
//     time: "2:00 PM",
//     location: "San Francisco, CA",
//     imageUrl: "29", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "dYDsm4Vogjc4LWLGMaSZCIufQux1"],
//     isPublic: true,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Tech Trends for 2025",
//     description: "A discussion on the emerging technology trends for the year 2025.",
//     date: DateTime(2025, 1, 10),
//     time: "9:30 AM",
//     location: "Chicago, IL",
//     imageUrl: "30", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: false,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "Future of Artificial Intelligence in Healthcare",
//     description: "Explore how AI is transforming the healthcare industry.",
//     date: DateTime(2025, 1, 12),
//     time: "11:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "31", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "JSv2GoLB3AX2bu7PHtkTe22o7LF3"],
//     isPublic: true,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "Web Development Bootcamp",
//     description: "A bootcamp focusing on the latest trends and frameworks in web development.",
//     date: DateTime(2025, 1, 13),
//     time: "10:00 AM",
//     location: "Chicago, IL",
//     imageUrl: "32", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "VCYZdLohGbU2vqtd5yRPZTTPXln1"],
//     isPublic: false,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Data Science: Beyond the Basics",
//     description: "Learn advanced data science techniques and tools for real-world problems.",
//     date: DateTime(2025, 1, 14),
//     time: "3:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "33", // Image URL between 1 and 46
//     organizerId: "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     participants: ["VCYZdLohGbU2vqtd5yRPZTTPXln1", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "Cyber Security for Remote Work",
//     description: "Protecting businesses and individuals from cybersecurity threats in a remote environment.",
//     date: DateTime(2025, 1, 15),
//     time: "9:30 AM",
//     location: "New York, NY",
//     imageUrl: "34", // Image URL between 1 and 46
//     organizerId: "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "dYDsm4Vogjc4LWLGMaSZCIufQux1"],
//     isPublic: true,
//     categoryId: "268614b1-fd0b-4b33-a24d-6162d4df0886",
//   ),
//   Event(
//     title: "Next-Gen UI/UX Design for Mobile Apps",
//     description: "An interactive session on creating seamless UI/UX designs for mobile platforms.",
//     date: DateTime(2025, 1, 16),
//     time: "2:00 PM",
//     location: "San Francisco, CA",
//     imageUrl: "35", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: false,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Digital Marketing Strategies for 2025",
//     description: "A session on the latest digital marketing techniques and strategies for 2025.",
//     date: DateTime(2025, 1, 17),
//     time: "10:30 AM",
//     location: "Chicago, IL",
//     imageUrl: "36", // Image URL between 1 and 46
//     organizerId: "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "m18RsrYElTR0tTjyaiuevIIAUjf2"],
//     isPublic: true,
//     categoryId: "e0359913-2024-447a-bfd2-edff6a9a0728",
//   ),
//   Event(
//     title: "AI in E-Commerce",
//     description: "How AI is changing the landscape of online retail and e-commerce platforms.",
//     date: DateTime(2025, 1, 18),
//     time: "1:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "37", // Image URL between 1 and 46
//     organizerId: "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "AqsauIfPHxajYR20eiqGHxyDWxl1"],
//     isPublic: false,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "The Future of Blockchain Technology",
//     description: "Discuss the future trends and applications of blockchain technology.",
//     date: DateTime(2025, 1, 19),
//     time: "11:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "38", // Image URL between 1 and 46
//     organizerId: "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "m18RsrYElTR0tTjyaiuevIIAUjf2"],
//     isPublic: true,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "AI in Finance",
//     description: "Explore the applications of AI in the financial services industry.",
//     date: DateTime(2025, 1, 20),
//     time: "3:00 PM",
//     location: "Miami, FL",
//     imageUrl: "39", // Image URL between 1 and 46
//     organizerId: "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "qmqllcFjVPgHc0MV4Q4PfehF3hL2"],
//     isPublic: true,
//     categoryId: "0a45f0e6-61bb-40f9-9ce6-c5f7c1f941dc",
//   ),
//   Event(
//     title: "Web Development: Mastering JavaScript",
//     description: "A deep dive into JavaScript and its latest features for web development.",
//     date: DateTime(2025, 1, 21),
//     time: "10:00 AM",
//     location: "New York, NY",
//     imageUrl: "40", // Image URL between 1 and 46
//     organizerId: "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "m18RsrYElTR0tTjyaiuevIIAUjf2"],
//     isPublic: false,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "AI-Powered Business Analytics",
//     description: "A session on how AI is transforming business analytics and decision-making.",
//     date: DateTime(2025, 1, 22),
//     time: "2:30 PM",
//     location: "San Francisco, CA",
//     imageUrl: "41", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: ["AqsauIfPHxajYR20eiqGHxyDWxl1", "VCYZdLohGbU2vqtd5yRPZTTPXln1"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "UI/UX Design Trends for 2025",
//     description: "Learn about the latest UI/UX design trends and their impact on user experience.",
//     date: DateTime(2025, 1, 23),
//     time: "11:30 AM",
//     location: "Chicago, IL",
//     imageUrl: "42", // Image URL between 1 and 46
//     organizerId: "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "AqsauIfPHxajYR20eiqGHxyDWxl1"],
//     isPublic: false,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Mastering Digital Marketing",
//     description: "Advanced strategies and tools for mastering digital marketing in 2025.",
//     date: DateTime(2025, 1, 24),
//     time: "4:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "43", // Image URL between 1 and 46
//     organizerId: "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "m18RsrYElTR0tTjyaiuevIIAUjf2"],
//     isPublic: true,
//     categoryId: "e0359913-2024-447a-bfd2-edff6a9a0728",
//   ),
//   Event(
//     title: "Cybersecurity for Startups",
//     description: "A guide to implementing basic cybersecurity measures for startups.",
//     date: DateTime(2025, 1, 25),
//     time: "9:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "44", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "JSv2GoLB3AX2bu7PHtkTe22o7LF3"],
//     isPublic: true,
//     categoryId: "268614b1-fd0b-4b33-a24d-6162d4df0886",
//   ),
//   Event(
//     title: "AI-Driven Design Tools for Creatives",
//     description: "Learn how AI tools are revolutionizing the design process for creatives.",
//     date: DateTime(2025, 1, 26),
//     time: "10:30 AM",
//     location: "Chicago, IL",
//     imageUrl: "45", // Image URL between 1 and 46
//     organizerId: "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//     participants: ["JSv2GoLB3AX2bu7PHtkTe22o7LF3", "AqsauIfPHxajYR20eiqGHxyDWxl1"],
//     isPublic: false,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "The Rise of Digital Twins in Manufacturing",
//     description: "A session on how digital twins are transforming the manufacturing industry.",
//     date: DateTime(2025, 1, 27),
//     time: "1:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "46", // Image URL between 1 and 46
//     organizerId: "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     participants: ["CqPG0YgwBzaUgDQaTIE6DdToXHZ2", "iP8HPYBpQnWIfS3m98jZLZ3MNmW2"],
//     isPublic: true,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "AI and Machine Learning Revolution",
//     description: "Explore the cutting-edge trends in AI and machine learning.",
//     date: DateTime(2025, 2, 1),
//     time: "9:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "1", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: [
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//       "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     ],
//     isPublic: true,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "Digital Marketing in the Modern World",
//     description: "Learn the latest strategies in digital marketing for 2025.",
//     date: DateTime(2025, 2, 2),
//     time: "10:30 AM",
//     location: "New York, NY",
//     imageUrl: "2", // Image URL between 1 and 46
//     organizerId: "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//     participants: [
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//       "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     ],
//     isPublic: false,
//     categoryId: "e0359913-2024-447a-bfd2-edff6a9a0728",
//   ),
//   Event(
//     title: "Cybersecurity for the Digital Age",
//     description: "Learn about the latest cybersecurity threats and solutions.",
//     date: DateTime(2025, 2, 3),
//     time: "12:00 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "3", // Image URL between 1 and 46
//     organizerId: "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//     participants: [
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//       "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     ],
//     isPublic: true,
//     categoryId: "268614b1-fd0b-4b33-a24d-6162d4df0886",
//   ),
//   Event(
//     title: "Mastering AI Tools for Business",
//     description: "Discover how AI tools can enhance business operations and decision-making.",
//     date: DateTime(2025, 2, 4),
//     time: "2:00 PM",
//     location: "Chicago, IL",
//     imageUrl: "4", // Image URL between 1 and 46
//     organizerId: "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     participants: [
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     ],
//     isPublic: false,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
//   Event(
//     title: "Web Development: Building Modern Applications",
//     description: "A workshop on modern web development frameworks and tools.",
//     date: DateTime(2025, 2, 5),
//     time: "11:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "5", // Image URL between 1 and 46
//     organizerId: "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     participants: [
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//       "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     ],
//     isPublic: true,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "Advanced UI/UX Design Principles",
//     description: "A session on advanced UI/UX design principles for modern applications.",
//     date: DateTime(2025, 2, 6),
//     time: "1:00 PM",
//     location: "New York, NY",
//     imageUrl: "6", // Image URL between 1 and 46
//     organizerId: "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//     participants: [
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     ],
//     isPublic: true,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Blockchain Technology for Beginners",
//     description: "An introductory session to understanding blockchain and its applications.",
//     date: DateTime(2025, 2, 7),
//     time: "3:30 PM",
//     location: "Chicago, IL",
//     imageUrl: "7", // Image URL between 1 and 46
//     organizerId: "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     participants: [
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     ],
//     isPublic: false,
//     categoryId: "1b34ea8a-bf52-43d3-acaf-38d3ad89bf6e",
//   ),
//   Event(
//     title: "Digital Marketing for E-commerce",
//     description: "Learn the latest digital marketing strategies for the e-commerce sector.",
//     date: DateTime(2025, 2, 8),
//     time: "10:00 AM",
//     location: "San Francisco, CA",
//     imageUrl: "8", // Image URL between 1 and 46
//     organizerId: "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//     participants: [
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//       "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     ],
//     isPublic: true,
//     categoryId: "e0359913-2024-447a-bfd2-edff6a9a0728",
//   ),
//   Event(
//     title: "Web Development Bootcamp",
//     description: "A bootcamp for aspiring web developers to learn full-stack development.",
//     date: DateTime(2025, 2, 9),
//     time: "9:30 AM",
//     location: "New York, NY",
//     imageUrl: "9", // Image URL between 1 and 46
//     organizerId: "AqsauIfPHxajYR20eiqGHxyDWxl1",
//     participants: [
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//       "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//     ],
//     isPublic: false,
//     categoryId: "1b388593-9fc0-4e12-98e9-85a21f4e07eb",
//   ),
//   Event(
//     title: "UI/UX Design for E-commerce",
//     description: "A hands-on workshop focusing on UI/UX design strategies for e-commerce websites.",
//     date: DateTime(2025, 2, 10),
//     time: "4:00 PM",
//     location: "Chicago, IL",
//     imageUrl: "10", // Image URL between 1 and 46
//     organizerId: "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     participants: [
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "m18RsrYElTR0tTjyaiuevIIAUjf2",
//     ],
//     isPublic: true,
//     categoryId: "735dc0af-501f-46b7-b975-49a304dc0620",
//   ),
//   Event(
//     title: "Data Science for Business Professionals",
//     description: "A workshop on how business professionals can leverage data science.",
//     date: DateTime(2025, 2, 11),
//     time: "12:30 PM",
//     location: "Los Angeles, CA",
//     imageUrl: "11", // Image URL between 1 and 46
//     organizerId: "dYDsm4Vogjc4LWLGMaSZCIufQux1",
//     participants: [
//       "CqPG0YgwBzaUgDQaTIE6DdToXHZ2",
//       "JSv2GoLB3AX2bu7PHtkTe22o7LF3",
//       "iP8HPYBpQnWIfS3m98jZLZ3MNmW2",
//       "VCYZdLohGbU2vqtd5yRPZTTPXln1",
//       "AqsauIfPHxajYR20eiqGHxyDWxl1",
//       "qmqllcFjVPgHc0MV4Q4PfehF3hL2",
//     ],
//     isPublic: false,
//     categoryId: "46219624-d55f-48a4-81a6-c1a22ad0bf4f",
//   ),
// ];

