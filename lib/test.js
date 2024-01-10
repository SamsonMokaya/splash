const Database = require("../models/database");
const jwt = require("jsonwebtoken");

exports.getIndexPage = async (req, res, next) => {
  res.status(200).json(await Database.allStudents());
};

exports.postUserContent = (req, res, next) => {
  const token = req.cookies.jwt;
  if (token) {
    jwt.verify(token, process.env.JSW_TOKEN, async (err, decodedToken) => {
      if (err) {
        return res.redirect("/login");
      }
      let {
        adm_num,
        session_id,
        determinant,
        data: { latitude, longitude, accuracy },
      } = req.body;

      await Database.createStudentAttendance({
        adm_num,
        session_id,
        latitude,
        longitude,
        determinant,
        accuracy,
      })
        .then((data) => {
          return res.json({redirect: `/users/dashboard/${decodedToken.adm_num}`});
        })
        .catch((err) => {
          return res.status(401).json(err);
        });
    });
  } else {
    return res.redirect("/logout");
  }
};

exports.getAttendances = (req, res, next) => {
  const token = req.cookies.jwt;
  if (token) {
    jwt.verify(token, process.env.JSW_TOKEN, async (err, decodedToken) => {
      const admNumber = decodedToken.adm_num;
      Promise.all([
        Database.findOneStudent({ adm_num: admNumber }),
        Database.getAllSessions(),
        Database.studentAttendances({ adm_num: admNumber }),
        Database.allStudents(),
      ]).then((result) => {
        res.json({
          sessions: result[1],
          data: result[2],
          student: result[0],
          users: result[3].map((v) => {
            return {
              first_name: v.first_name,
              email: v.email,
              full_name: getNameFromEmail(v.first_name, v.email),
              role: v.role,
              adm_number: v.adm_number,
            };
          }),
        });
      });
    });
  } else {
    return res.status(401).json({message: "User Not allowed: token failed"});
  }
};
