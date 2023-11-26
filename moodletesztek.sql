-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 26, 2023 at 09:35 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moodletesztek`
--

-- --------------------------------------------------------

--
-- Table structure for table `Questions`
--

CREATE TABLE `Questions` (
  `question_id` int(11) NOT NULL,
  `question_text` text DEFAULT NULL,
  `correct_answer_index` int(11) DEFAULT NULL,
  `answer1` text DEFAULT NULL,
  `answer2` text DEFAULT NULL,
  `answer3` text DEFAULT NULL,
  `answer4` text DEFAULT NULL,
  `answer5` text DEFAULT NULL,
  `max_score` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Questions`
--

INSERT INTO `Questions` (`question_id`, `question_text`, `correct_answer_index`, `answer1`, `answer2`, `answer3`, `answer4`, `answer5`, `max_score`) VALUES
(37, 'What is the capital of South Africa?', 1, 'Pretoria', 'Johannesburg', 'Cape Town', 'Durban', 'Bloemfontein', 10),
(38, 'Who is the author of \"The Hobbit\"?', 3, 'J.K. Rowling', 'George R.R. Martin', 'J.R.R. Tolkien', 'C.S. Lewis', 'Philip Pullman', 10),
(39, 'What is the largest ocean on Earth?', 1, 'Pacific Ocean', 'Atlantic Ocean', 'Indian Ocean', 'Southern Ocean', 'Arctic Ocean', 10),
(40, 'Who is known as the \"Queen of Pop\"?', 2, 'Madonna', 'Beyoncé', 'Rihanna', 'Lady Gaga', 'Taylor Swift', 10),
(41, 'What is the capital of Canada?', 4, 'Ottawa', 'Toronto', 'Vancouver', 'Montreal', 'Calgary', 10),
(42, 'Who wrote \"Pride and Prejudice\"?', 1, 'Jane Austen', 'Charlotte Brontë', 'Emily Brontë', 'Charles Dickens', 'Leo Tolstoy', 10),
(43, 'What is the chemical symbol for gold?', 5, 'Go', 'Ge', 'Gd', 'Au', 'Ag', 10),
(44, 'What is the currency of Switzerland?', 2, 'Euro', 'Swiss Franc', 'British Pound', 'US Dollar', 'Japanese Yen', 10),
(45, 'Who played Jack Dawson in the movie \"Titanic\"?', 4, 'Brad Pitt', 'Matthew McConaughey', 'Leonardo DiCaprio', 'Tom Cruise', 'Johnny Depp', 10),
(46, 'What is the capital of Argentina?', 1, 'Buenos Aires', 'Rio de Janeiro', 'Sao Paulo', 'Lima', 'Bogota', 10),
(47, 'What is the largest desert in the world?', 3, 'Gobi Desert', 'Sahara Desert', 'Antarctica', 'Arabian Desert', 'Kalihari Desert', 10),
(48, 'Who is the lead singer of the band Coldplay?', 4, 'Chris Martin', 'Bono', 'Thom Yorke', 'Dave Grohl', 'Eddie Vedder', 10),
(49, 'What is the smallest bone in the human body?', 5, 'Femur', 'Radius', 'Ulna', 'Tibia', 'Stapes (in the ear)', 10),
(50, 'In which country did the Olympic Games originate?', 3, 'Greece', 'Italy', 'France', 'Germany', 'United Kingdom', 10),
(51, 'Who wrote \"The Picture of Dorian Gray\"?', 1, 'Oscar Wilde', 'Jane Austen', 'F. Scott Fitzgerald', 'George Orwell', 'Charles Dickens', 10),
(52, 'What is the largest bird in the world?', 5, 'Eagle', 'Ostrich', 'Penguin', 'Parrot', 'Albatross', 10),
(53, 'Who painted \"The Starry Night\"?', 1, 'Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet', 'Michelangelo', 10);

-- --------------------------------------------------------

--
-- Table structure for table `Question_in_Test`
--

CREATE TABLE `Question_in_Test` (
  `relation_id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Question_in_Test`
--

INSERT INTO `Question_in_Test` (`relation_id`, `question_id`, `test_id`) VALUES
(58, 37, 5),
(59, 38, 5),
(60, 39, 5),
(61, 40, 5),
(62, 41, 5),
(63, 42, 5),
(64, 43, 5),
(65, 44, 5),
(66, 45, 5),
(67, 46, 5),
(68, 47, 5),
(69, 48, 5),
(70, 49, 5),
(71, 50, 5),
(72, 51, 5),
(73, 52, 5),
(74, 53, 5),
(75, 37, 2),
(76, 38, 2),
(77, 39, 2),
(78, 40, 2),
(79, 41, 2),
(80, 42, 3),
(81, 43, 3),
(82, 44, 3),
(83, 45, 3),
(84, 46, 3),
(85, 47, 4),
(86, 48, 4),
(87, 49, 4),
(88, 50, 4),
(89, 51, 4),
(90, 52, 4),
(91, 53, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Submissions`
--

CREATE TABLE `Submissions` (
  `submission_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  `submission_time` datetime DEFAULT NULL,
  `results` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Submissions`
--

INSERT INTO `Submissions` (`submission_id`, `user_id`, `test_id`, `submission_time`, `results`) VALUES
(84, 1, 5, '2023-11-25 23:38:55', 20),
(85, 1, 5, '2023-11-25 23:39:12', 30),
(86, 1, 5, '2023-11-25 23:39:28', 20),
(87, 1, 5, '2023-11-25 23:45:30', 40),
(88, 1, 2, '2023-11-25 23:45:50', 0),
(89, 1, 3, '2023-11-25 23:46:11', 0),
(90, 6, 3, '2023-11-25 23:47:06', 0),
(91, 6, 3, '2023-11-25 23:47:12', 10),
(92, 6, 3, '2023-11-25 23:47:18', 10),
(93, 6, 3, '2023-11-25 23:47:24', 10),
(94, 6, 3, '2023-11-25 23:47:30', 20),
(95, 6, 2, '2023-11-25 23:47:38', 20),
(96, 6, 2, '2023-11-25 23:47:42', 0),
(97, 6, 2, '2023-11-25 23:47:47', 20),
(98, 6, 2, '2023-11-25 23:47:51', 0),
(99, 6, 4, '2023-11-25 23:48:00', 0),
(100, 6, 4, '2023-11-25 23:48:06', 10),
(101, 6, 4, '2023-11-25 23:48:13', 20),
(102, 6, 5, '2023-11-25 23:48:24', 30),
(103, 6, 5, '2023-11-25 23:48:41', 40),
(104, 6, 5, '2023-11-25 23:48:56', 10),
(105, 6, 5, '2023-11-25 23:49:08', 20),
(106, 7, 2, '2023-11-25 23:49:35', 10),
(107, 7, 2, '2023-11-25 23:49:41', 10),
(108, 7, 2, '2023-11-25 23:49:48', 0),
(109, 7, 2, '2023-11-25 23:49:52', 0),
(110, 7, 3, '2023-11-25 23:50:00', 0),
(111, 7, 3, '2023-11-25 23:50:05', 10),
(112, 7, 3, '2023-11-25 23:50:10', 0),
(113, 7, 3, '2023-11-25 23:50:16', 20),
(114, 7, 3, '2023-11-25 23:50:20', 10),
(115, 7, 4, '2023-11-25 23:50:29', 10),
(116, 7, 4, '2023-11-25 23:50:38', 10),
(117, 7, 4, '2023-11-25 23:50:47', 10),
(118, 7, 4, '2023-11-25 23:50:56', 10),
(119, 7, 5, '2023-11-25 23:51:07', 10),
(120, 7, 5, '2023-11-25 23:51:26', 10),
(121, 7, 5, '2023-11-25 23:51:34', 20),
(122, 7, 5, '2023-11-25 23:51:50', 20),
(123, 8, 2, '2023-11-25 23:52:36', 10),
(124, 8, 2, '2023-11-25 23:52:42', 0),
(125, 8, 2, '2023-11-25 23:52:47', 10),
(126, 8, 2, '2023-11-25 23:52:52', 0),
(127, 8, 2, '2023-11-25 23:52:57', 0),
(128, 8, 3, '2023-11-25 23:53:03', 0),
(129, 8, 3, '2023-11-25 23:53:10', 10),
(130, 8, 3, '2023-11-25 23:53:15', 0),
(131, 8, 3, '2023-11-25 23:53:20', 0),
(132, 8, 4, '2023-11-25 23:53:29', 30),
(133, 8, 4, '2023-11-25 23:53:37', 10),
(134, 8, 4, '2023-11-25 23:53:43', 30),
(135, 8, 5, '2023-11-25 23:53:54', 20),
(136, 8, 5, '2023-11-25 23:54:11', 0),
(137, 8, 5, '2023-11-25 23:54:25', 0),
(150, 1, 5, '2023-11-26 00:12:57', 110);

-- --------------------------------------------------------

--
-- Table structure for table `Tests`
--

CREATE TABLE `Tests` (
  `test_id` int(11) NOT NULL,
  `test_name` varchar(255) DEFAULT NULL,
  `creation_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `min_score` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Tests`
--

INSERT INTO `Tests` (`test_id`, `test_name`, `creation_date`, `created_by`, `min_score`) VALUES
(2, 'Trivia(first 5 questions)', '2023-11-25', 3, 30),
(3, 'Trivia(second 5 questions)', '2023-11-25', 3, 20),
(4, 'Trivia(last 7 questions)', '2023-11-25', 4, 20),
(5, 'Trivia(every question)', '2023-11-25', 1, 170);

-- --------------------------------------------------------

--
-- Table structure for table `UserAnswers`
--

CREATE TABLE `UserAnswers` (
  `user_answer_id` int(11) NOT NULL,
  `submission_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `chosen_answer_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `UserAnswers`
--

INSERT INTO `UserAnswers` (`user_answer_id`, `submission_id`, `question_id`, `chosen_answer_index`) VALUES
(341, 84, 37, 3),
(342, 84, 38, 2),
(343, 84, 39, 3),
(344, 84, 40, 3),
(345, 84, 41, 2),
(346, 84, 42, 4),
(347, 84, 43, 2),
(348, 84, 44, 4),
(349, 84, 45, 2),
(350, 84, 46, 2),
(351, 84, 47, 2),
(352, 84, 48, 4),
(353, 84, 49, 2),
(354, 84, 50, 3),
(355, 84, 51, 2),
(356, 84, 52, 3),
(357, 84, 53, 2),
(358, 85, 37, 3),
(359, 85, 38, 4),
(360, 85, 39, 3),
(361, 85, 40, 3),
(362, 85, 41, 3),
(363, 85, 42, 1),
(364, 85, 43, 1),
(365, 85, 44, 2),
(366, 85, 45, 2),
(367, 85, 46, 3),
(368, 85, 47, 4),
(369, 85, 48, 3),
(370, 85, 49, 3),
(371, 85, 50, 3),
(372, 85, 51, 2),
(373, 85, 52, 3),
(374, 85, 53, 3),
(375, 86, 37, 2),
(376, 86, 38, 3),
(377, 86, 39, 4),
(378, 86, 40, 3),
(379, 86, 41, 3),
(380, 86, 42, 2),
(381, 86, 43, 3),
(382, 86, 44, 3),
(383, 86, 45, 3),
(384, 86, 46, 2),
(385, 86, 47, 2),
(386, 86, 48, 3),
(387, 86, 49, 3),
(388, 86, 50, 3),
(389, 86, 51, 3),
(390, 86, 52, 3),
(391, 86, 53, 2),
(392, 87, 37, 3),
(393, 87, 38, 3),
(394, 87, 39, 3),
(395, 87, 40, 3),
(396, 87, 41, 4),
(397, 87, 42, 3),
(398, 87, 43, 3),
(399, 87, 44, 3),
(400, 87, 45, 3),
(401, 87, 46, 2),
(402, 87, 47, 2),
(403, 87, 48, 5),
(404, 87, 49, 3),
(405, 87, 50, 3),
(406, 87, 51, 5),
(407, 87, 52, 3),
(408, 87, 53, 1),
(409, 90, 42, 2),
(410, 90, 43, 3),
(411, 90, 44, 3),
(412, 90, 45, 3),
(413, 90, 46, 3),
(414, 91, 42, 1),
(415, 91, 43, 3),
(416, 91, 44, 1),
(417, 91, 45, 3),
(418, 91, 46, 2),
(419, 92, 42, 3),
(420, 92, 43, 3),
(421, 92, 44, 2),
(422, 92, 45, 3),
(423, 92, 46, 2),
(424, 93, 42, 3),
(425, 93, 43, 3),
(426, 93, 44, 2),
(427, 93, 45, 2),
(428, 93, 46, 2),
(429, 94, 42, 2),
(430, 94, 43, 3),
(431, 94, 44, 2),
(432, 94, 45, 4),
(433, 94, 46, 2),
(434, 95, 37, 4),
(435, 95, 38, 3),
(436, 95, 39, 1),
(437, 95, 40, 3),
(438, 95, 41, 2),
(439, 96, 37, 3),
(440, 96, 38, 4),
(441, 96, 39, 2),
(442, 96, 40, 3),
(443, 96, 41, 2),
(444, 97, 37, 2),
(445, 97, 38, 4),
(446, 97, 39, 3),
(447, 97, 40, 2),
(448, 97, 41, 4),
(449, 98, 37, 3),
(450, 98, 38, 4),
(451, 98, 39, 5),
(452, 98, 40, 3),
(453, 98, 41, 2),
(454, 99, 47, 1),
(455, 99, 48, 3),
(456, 99, 49, 2),
(457, 99, 50, 2),
(458, 99, 51, 3),
(459, 99, 52, 4),
(460, 99, 53, 4),
(461, 100, 47, 3),
(462, 100, 48, 0),
(463, 100, 49, 2),
(464, 100, 50, 0),
(465, 100, 51, 0),
(466, 100, 52, 3),
(467, 100, 53, 4),
(468, 101, 47, 3),
(469, 101, 48, 2),
(470, 101, 49, 4),
(471, 101, 50, 3),
(472, 101, 51, 5),
(473, 101, 52, 2),
(474, 101, 53, 0),
(475, 102, 37, 4),
(476, 102, 38, 3),
(477, 102, 39, 3),
(478, 102, 40, 2),
(479, 102, 41, 3),
(480, 102, 42, 3),
(481, 102, 43, 3),
(482, 102, 44, 2),
(483, 102, 45, 3),
(484, 102, 46, 3),
(485, 102, 47, 5),
(486, 102, 48, 3),
(487, 102, 49, 3),
(488, 102, 50, 2),
(489, 102, 51, 3),
(490, 102, 52, 3),
(491, 102, 53, 4),
(492, 103, 37, 4),
(493, 103, 38, 4),
(494, 103, 39, 2),
(495, 103, 40, 2),
(496, 103, 41, 4),
(497, 103, 42, 2),
(498, 103, 43, 3),
(499, 103, 44, 4),
(500, 103, 45, 3),
(501, 103, 46, 2),
(502, 103, 47, 3),
(503, 103, 48, 3),
(504, 103, 49, 5),
(505, 103, 50, 4),
(506, 103, 51, 0),
(507, 103, 52, 0),
(508, 103, 53, 5),
(509, 104, 37, 4),
(510, 104, 38, 5),
(511, 104, 39, 4),
(512, 104, 40, 3),
(513, 104, 41, 5),
(514, 104, 42, 3),
(515, 104, 43, 4),
(516, 104, 44, 5),
(517, 104, 45, 5),
(518, 104, 46, 3),
(519, 104, 47, 4),
(520, 104, 48, 4),
(521, 104, 49, 4),
(522, 104, 50, 0),
(523, 104, 51, 0),
(524, 104, 52, 0),
(525, 104, 53, 0),
(526, 105, 37, 3),
(527, 105, 38, 5),
(528, 105, 39, 3),
(529, 105, 40, 2),
(530, 105, 41, 2),
(531, 105, 42, 3),
(532, 105, 43, 5),
(533, 105, 44, 4),
(534, 105, 45, 2),
(535, 105, 46, 3),
(536, 105, 47, 4),
(537, 105, 48, 3),
(538, 105, 49, 0),
(539, 105, 50, 0),
(540, 105, 51, 0),
(541, 105, 52, 4),
(542, 105, 53, 3),
(543, 106, 37, 2),
(544, 106, 38, 2),
(545, 106, 39, 1),
(546, 106, 40, 3),
(547, 106, 41, 2),
(548, 107, 37, 4),
(549, 107, 38, 2),
(550, 107, 39, 4),
(551, 107, 40, 2),
(552, 107, 41, 1),
(553, 108, 37, 3),
(554, 108, 38, 4),
(555, 108, 39, 4),
(556, 108, 40, 0),
(557, 108, 41, 0),
(558, 109, 37, 0),
(559, 109, 38, 2),
(560, 109, 39, 3),
(561, 109, 40, 0),
(562, 109, 41, 3),
(563, 110, 42, 3),
(564, 110, 43, 2),
(565, 110, 44, 4),
(566, 110, 45, 2),
(567, 110, 46, 2),
(568, 111, 42, 2),
(569, 111, 43, 3),
(570, 111, 44, 2),
(571, 111, 45, 1),
(572, 111, 46, 3),
(573, 112, 42, 3),
(574, 112, 43, 3),
(575, 112, 44, 3),
(576, 112, 45, 3),
(577, 112, 46, 4),
(578, 113, 42, 4),
(579, 113, 43, 2),
(580, 113, 44, 2),
(581, 113, 45, 4),
(582, 113, 46, 2),
(583, 114, 42, 3),
(584, 114, 43, 3),
(585, 114, 44, 4),
(586, 114, 45, 4),
(587, 114, 46, 2),
(588, 115, 47, 3),
(589, 115, 48, 3),
(590, 115, 49, 3),
(591, 115, 50, 2),
(592, 115, 51, 4),
(593, 115, 52, 3),
(594, 115, 53, 2),
(595, 116, 47, 0),
(596, 116, 48, 2),
(597, 116, 49, 3),
(598, 116, 50, 4),
(599, 116, 51, 1),
(600, 116, 52, 3),
(601, 116, 53, 4),
(602, 117, 47, 5),
(603, 117, 48, 4),
(604, 117, 49, 2),
(605, 117, 50, 1),
(606, 117, 51, 4),
(607, 117, 52, 3),
(608, 117, 53, 3),
(609, 118, 47, 3),
(610, 118, 48, 5),
(611, 118, 49, 3),
(612, 118, 50, 2),
(613, 118, 51, 5),
(614, 118, 52, 4),
(615, 118, 53, 0),
(616, 119, 37, 3),
(617, 119, 38, 1),
(618, 119, 39, 3),
(619, 119, 40, 4),
(620, 119, 41, 3),
(621, 119, 42, 1),
(622, 119, 43, 2),
(623, 119, 44, 3),
(624, 119, 45, 2),
(625, 119, 46, 3),
(626, 119, 47, 2),
(627, 119, 48, 3),
(628, 119, 49, 2),
(629, 119, 50, 4),
(630, 119, 51, 2),
(631, 119, 52, 2),
(632, 119, 53, 2),
(633, 120, 37, 0),
(634, 120, 38, 2),
(635, 120, 39, 4),
(636, 120, 40, 0),
(637, 120, 41, 0),
(638, 120, 42, 2),
(639, 120, 43, 0),
(640, 120, 44, 5),
(641, 120, 45, 0),
(642, 120, 46, 0),
(643, 120, 47, 0),
(644, 120, 48, 0),
(645, 120, 49, 0),
(646, 120, 50, 0),
(647, 120, 51, 1),
(648, 120, 52, 4),
(649, 120, 53, 0),
(650, 121, 37, 3),
(651, 121, 38, 1),
(652, 121, 39, 5),
(653, 121, 40, 1),
(654, 121, 41, 4),
(655, 121, 42, 2),
(656, 121, 43, 3),
(657, 121, 44, 3),
(658, 121, 45, 1),
(659, 121, 46, 2),
(660, 121, 47, 3),
(661, 121, 48, 1),
(662, 121, 49, 2),
(663, 121, 50, 4),
(664, 121, 51, 5),
(665, 121, 52, 4),
(666, 121, 53, 2),
(667, 122, 37, 5),
(668, 122, 38, 2),
(669, 122, 39, 4),
(670, 122, 40, 2),
(671, 122, 41, 2),
(672, 122, 42, 5),
(673, 122, 43, 2),
(674, 122, 44, 3),
(675, 122, 45, 3),
(676, 122, 46, 0),
(677, 122, 47, 0),
(678, 122, 48, 0),
(679, 122, 49, 0),
(680, 122, 50, 0),
(681, 122, 51, 2),
(682, 122, 52, 5),
(683, 122, 53, 3),
(684, 123, 37, 2),
(685, 123, 38, 2),
(686, 123, 39, 3),
(687, 123, 40, 2),
(688, 123, 41, 3),
(689, 124, 37, 4),
(690, 124, 38, 1),
(691, 124, 39, 0),
(692, 124, 40, 3),
(693, 124, 41, 1),
(694, 125, 37, 4),
(695, 125, 38, 2),
(696, 125, 39, 3),
(697, 125, 40, 2),
(698, 125, 41, 2),
(699, 126, 37, 4),
(700, 126, 38, 4),
(701, 126, 39, 3),
(702, 126, 40, 3),
(703, 126, 41, 3),
(704, 128, 42, 3),
(705, 128, 43, 3),
(706, 128, 44, 3),
(707, 128, 45, 3),
(708, 128, 46, 3),
(709, 129, 42, 4),
(710, 129, 43, 3),
(711, 129, 44, 3),
(712, 129, 45, 3),
(713, 129, 46, 1),
(714, 130, 42, 3),
(715, 130, 43, 3),
(716, 130, 44, 4),
(717, 130, 45, 3),
(718, 130, 46, 3),
(719, 131, 42, 4),
(720, 131, 43, 3),
(721, 131, 44, 4),
(722, 131, 45, 2),
(723, 131, 46, 3),
(724, 132, 47, 3),
(725, 132, 48, 4),
(726, 132, 49, 2),
(727, 132, 50, 3),
(728, 132, 51, 3),
(729, 132, 52, 0),
(730, 132, 53, 5),
(731, 133, 47, 5),
(732, 133, 48, 1),
(733, 133, 49, 4),
(734, 133, 50, 0),
(735, 133, 51, 4),
(736, 133, 52, 3),
(737, 133, 53, 1),
(738, 134, 47, 0),
(739, 134, 48, 4),
(740, 134, 49, 0),
(741, 134, 50, 0),
(742, 134, 51, 1),
(743, 134, 52, 5),
(744, 134, 53, 5),
(745, 135, 37, 3),
(746, 135, 38, 1),
(747, 135, 39, 5),
(748, 135, 40, 2),
(749, 135, 41, 3),
(750, 135, 42, 3),
(751, 135, 43, 3),
(752, 135, 44, 3),
(753, 135, 45, 3),
(754, 135, 46, 2),
(755, 135, 47, 3),
(756, 135, 48, 3),
(757, 135, 49, 2),
(758, 135, 50, 1),
(759, 135, 51, 2),
(760, 135, 52, 0),
(761, 135, 53, 2),
(762, 136, 37, 3),
(763, 136, 38, 2),
(764, 136, 39, 2),
(765, 136, 40, 3),
(766, 136, 41, 1),
(767, 136, 42, 2),
(768, 136, 43, 3),
(769, 136, 44, 4),
(770, 136, 45, 2),
(771, 136, 46, 3),
(772, 136, 47, 1),
(773, 136, 48, 0),
(774, 136, 49, 0),
(775, 136, 50, 0),
(776, 136, 51, 0),
(777, 136, 52, 0),
(778, 136, 53, 5),
(779, 137, 37, 0),
(780, 137, 38, 0),
(781, 137, 39, 0),
(782, 137, 40, 0),
(783, 137, 41, 0),
(784, 137, 42, 0),
(785, 137, 43, 0),
(786, 137, 44, 0),
(787, 137, 45, 0),
(788, 137, 46, 0),
(789, 137, 47, 0),
(790, 137, 48, 0),
(791, 137, 49, 0),
(792, 137, 50, 0),
(793, 137, 51, 0),
(794, 137, 52, 0),
(795, 137, 53, 0),
(840, 150, 37, 1),
(841, 150, 38, 3),
(842, 150, 39, 1),
(843, 150, 40, 1),
(844, 150, 41, 1),
(845, 150, 42, 1),
(846, 150, 43, 5),
(847, 150, 44, 2),
(848, 150, 45, 3),
(849, 150, 46, 1),
(850, 150, 47, 3),
(851, 150, 48, 1),
(852, 150, 49, 5),
(853, 150, 50, 1),
(854, 150, 51, 1),
(855, 150, 52, 2),
(856, 150, 53, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `cookie` varchar(255) DEFAULT 'NULL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_id`, `username`, `password`, `name`, `role`, `cookie`) VALUES
(1, 'admin', '$2b$10$s1XILTMGlMRNf0LZlYx4JOWfYeYQAmnrTPkdVyA0tDCB/ADSjB6di', 'Kiss Csaba', 'admin', NULL),
(2, 'teacher1', '$2b$10$SRX8HcohBbO/zjKYeps4levZoV4kY5L8F.GxxPt1KI0zrfqyddbFe', 'Csete Medárd', 'teacher', NULL),
(3, 'teacher2', '$2b$10$vtORfJNBhJJa9wP0kWWj4..bxbq2t.aIwcNSUd.IKXwXQjt0bTEyG', 'Soós Leopold', 'teacher', 'NULL'),
(4, 'teacher3', '$2b$10$sC5p8aAeBPRKVcdHdmpn2ejgwkFZRVD6Ck0zUlFQmg2Br6dtI6OAC', 'Csángó Szilveszter', 'teacher', 'NULL'),
(6, 'student1', '$2b$10$Ep1wpP0J2XwQf4StmSVjaO.ml/joXAQ0dxMiL08fxkVRLooCybtzK', 'Pászka Kornél', 'student', 'SrRrDd1S0NCrR56MkrvuUddeTnaqZhP2'),
(7, 'student2', '$2b$10$K02nWGn5zxfOYGKyKcKwWuDo56kinnhXsZsHqA82hNwDsJDsNLwtm', 'Gajda Tódor', 'student', NULL),
(8, 'student3', '$2b$10$JKp7ZliXRb0ThkIFcsq9SuSmZf4XLjdVzIyr7liyKnOJwLROGmin6', 'Richtinger Boldizsár', 'student', NULL),
(9, 'user1', '$2b$10$px19bOGtWdhBhlLuqMzD5OKxZDEBLaG7uv12SB6jwoL7LPzBxOr66', 'user1', 'student', 'NULL'),
(10, 'user2', '$2b$10$M9r0zGeaRnS3/CSqmdcpKumgTQsLB5Rvt/EiL2bwJIZIBUG/EWAHi', 'user2', 'student', 'NULL'),
(11, 'user3', '$2b$10$rM6WVaQWozEgI/Fvpsqaa.at6LKQWRcojWbKy6SHVF1fPOTaUgQR.', 'user3', 'student', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Questions`
--
ALTER TABLE `Questions`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `Question_in_Test`
--
ALTER TABLE `Question_in_Test`
  ADD PRIMARY KEY (`relation_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `Submissions`
--
ALTER TABLE `Submissions`
  ADD PRIMARY KEY (`submission_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `Tests`
--
ALTER TABLE `Tests`
  ADD PRIMARY KEY (`test_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `UserAnswers`
--
ALTER TABLE `UserAnswers`
  ADD PRIMARY KEY (`user_answer_id`),
  ADD KEY `submission_id` (`submission_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Questions`
--
ALTER TABLE `Questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `Question_in_Test`
--
ALTER TABLE `Question_in_Test`
  MODIFY `relation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `Submissions`
--
ALTER TABLE `Submissions`
  MODIFY `submission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `Tests`
--
ALTER TABLE `Tests`
  MODIFY `test_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `UserAnswers`
--
ALTER TABLE `UserAnswers`
  MODIFY `user_answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=857;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Question_in_Test`
--
ALTER TABLE `Question_in_Test`
  ADD CONSTRAINT `question_in_test_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `Questions` (`question_id`),
  ADD CONSTRAINT `question_in_test_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `Tests` (`test_id`);

--
-- Constraints for table `Submissions`
--
ALTER TABLE `Submissions`
  ADD CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  ADD CONSTRAINT `submissions_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `Tests` (`test_id`);

--
-- Constraints for table `Tests`
--
ALTER TABLE `Tests`
  ADD CONSTRAINT `tests_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `UserAnswers`
--
ALTER TABLE `UserAnswers`
  ADD CONSTRAINT `useranswers_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `Submissions` (`submission_id`),
  ADD CONSTRAINT `useranswers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `Questions` (`question_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
