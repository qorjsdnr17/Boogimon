import React, { useContext, useEffect, useRef, useState } from 'react';
import Header from '../Components/Header';
import styled from 'styled-components';
import { useNavigate } from 'react-router-dom';
import { AppContext } from '../App';
import boogi from '../boogi';
import axios from 'axios';
import { SHA256 } from 'crypto-js';
import avatar from '../images/avatar.png';

const Warp = styled.div`
  width: 100vw;
  height: 100vh;
  position: relative;
`;

const Title = styled.span`
  font-size: var(--big);
  font-weight: bold;
  position: absolute;
  left: 44%;
  top: -6%;
`;

const Button = styled.button`
  border: 2px solid var(--gray2);
  border-radius: 4px;
  background-color: #ffffff;
  padding: 15px 25px;
  width: 138px;
  box-sizing: border-box;
  margin-left: 10px;
  &:hover {
    cursor: pointer;
    background-color: var(--yellow);
    border: 2px solid var(--light-blue);
  }
`;

const Form = styled.form.attrs({
  enctype: 'multipart/form-data',
  method: 'POST',
})`
  width: 735px;
  margin: 15% 38%;
  position: relative;
`;

const Input = styled.input.attrs({ required: true })`
  width: 438px;
  height: 50px;
  border: 1px solid var(--gray2);
  border-radius: 5px;
  box-sizing: border-box;
  padding: 10px;
`;

const Pwd = styled(Input).attrs({
  type: 'password',
  name: 'password',
  id: 'password',
  placeholder: '비밀번호 변경',
  maxlength: '20',
})`
  clear: both;
  margin-bottom: 6px;
`;

const PwdConfirm = styled(Input).attrs({
  type: 'password',
  name: 'passwdConfirm',
  id: 'passwdConfirm',
  placeholder: '비밀번호 변경 확인',
  maxlength: '20',
})`
  margin-bottom: 10px;
`;

const Id = styled.div`
  width: 438px;
  height: 50px;
  border: 1px solid var(--gray1);
  border-radius: 5px;
  box-sizing: border-box;
  padding: 10px;
  margin-bottom: 10px;
`;

const Nickname = styled(Id)`
  float: left;
`;

const Adiv = styled.div`
  width: 700px;
`;

const Edit = styled.span`
  color: var(--gray2);
  text-decoration-line: underline;
  &:hover,
  &:focus {
    cursor: pointer;
    color: var(--black);
  }
`;

const PopupBg = styled.div`
  width: 100vw;
  height: 100vh;
  background-color: rgb(0 0 0 / 18%);
`;

const ModelBox = styled.div`
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0%;
  left: 0%;
`;
const Model = styled.div`
  width: 260px;
  height: 8vh;
  border: 2px solid var(--gray2);
  border-radius: 25px;
  position: fixed;
  top: 43%;
  left: 41%;
  background-color: white;
`;

const DeleteBox = styled.div`
  width: 195px;
  position: relative;
  top: 12%;
  left: 15%;
`;
const DeleteMsg = styled.span`
  font-size: var(--regular);
`;

const DeleteButton = styled.button`
  border: 2px solid var(--gray2);
  border-radius: 4px;
  background-color: #ffffff;
  padding: 5px 15px;
  box-sizing: border-box;
  margin-left: 10px;
  &:hover {
    cursor: pointer;
    background-color: var(--yellow);
    border: 2px solid var(--light-blue);
  }
`;

const ErrMsg = styled.div`
  color: red;
`;

const MyProfileImg = styled.img`
  width: 120px;
  height: 120px;
  object-fit: cover;
`;

const MyImg = styled.div`
  width: 120px;
  height: 120px;
  border-radius: 50%;
  position: absolute;
  top: -4%;
  left: -19%;
  overflow: hidden;
  background-color: var(--gray1);
`;

const EditUserInfo = () => {
  const [popupOn, setPopupOn] = useState(false);
  const [apiData, setApiData] = useState({ user: [] });
  const { isLogin } = useContext(AppContext);

  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');

  const [passwordError, setPasswordError] = useState('');
  const [confirmError, setConfirmError] = useState('');

  const sessionId = sessionStorage.getItem('userId');

  const { setIsLogin } = useContext(AppContext);

  const [image, setImage] = useState(avatar);
  const fileInput = useRef(null);

  const onChange = (e) => {
    e.preventDefault();

    axios
      .post(
        `http://localhost:8080/boogimon/user/user.jsp?command=changeImg`,
        null,
        {
          params: {
            userId: sessionId,
            profileImg: image,
          },
        }
      )
      .then((res) => {
        if (!e.target.files[0]) {
          setImage(avatar);
          return;
        }
        //화면에 프로필 사진 표시
        const reader = new FileReader();
        reader.onload = () => {
          if (reader.readyState === 2) {
            setImage(reader.result);
          }
        };
        res.reader.readAsDataURL(e.target.files[0]);
      });
  };

  useEffect(() => {
    boogi
      .get(
        `/boogimon/user/user.jsp?userId=${window.sessionStorage?.getItem(
          'userId'
        )}`
      )
      .then((response) => {
        setApiData(response.data);
        console.log(response.data);
      });
  }, [isLogin]);

  const onOpenPopup = () => {
    setPopupOn(!popupOn);
  };

  const navigate = useNavigate();
  const goHome = () => navigate('/', {});

  const passwordCheckHandler = (password, confirm) => {
    //정규표현식
    const passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,20}$/;
    // /^[a-z\d!@*&-_]{4,20}$/;
    if (password === '') {
      setPasswordError('비밀번호를 입력해주세요.');
      return false;
      //정규표현식 메서드(test)
    } else if (!passwordRegex.test(password)) {
      setPasswordError(
        '비밀번호는 4~20자의 영대소문자, 숫자만 입력 가능합니다.'
      );
      return false;
    } else if (confirm !== password) {
      setPasswordError('');
      setConfirmError('비밀번호가 일치하지 않습니다.');
      return false;
    } else {
      setPasswordError('');
      setConfirmError('');
      return true;
    }
  };

  const onChangePasswordHandler = (e) => {
    const { name, value } = e.target;
    if (name === 'password') {
      setPassword(value);
      passwordCheckHandler(value, confirm);
    } else {
      setConfirm(value);
      passwordCheckHandler(password, value);
    }
  };

  const onClickPasswordHandler = (event) => {
    event.preventDefault();

    boogi
      .post(`/boogimon/user/user.jsp?command=changePasswd`, null, {
        params: {
          userId: sessionId,
          newPasswd: SHA256(password).toString(),
        },
      })
      .then((res) => {
        if (res.password === res.confirm) {
          alert('비밀변호 변경이 완료되었습니다.');
          navigate('/');
          setIsLogin(false);
        }
      });
  };

  const Popup = () => {
    return (
      <ModelBox>
        <PopupBg />
        <Model>
          <DeleteBox>
            <DeleteMsg>
              정말 탈퇴하시겠습니까?
              <br />
              (탈퇴한 아이디로는 가입안됨)
            </DeleteMsg>
            <DeleteButton onClick={goHome}>예</DeleteButton>
            <DeleteButton onClick={onOpenPopup}>아니요</DeleteButton>
          </DeleteBox>
        </Model>
      </ModelBox>
    );
  };
  return (
    <>
      <Header />

      <Warp>
        <Title>회원정보수정</Title>

        <Form>
          <MyImg>
            {/* <MyProfileImg src={apiData.user.profileImg} alt='프로필이미지' /> */}
            <MyProfileImg
              src={image}
              onClick={() => {
                fileInput.current.click();
              }}
            />
            <input
              type='file'
              style={{ display: 'none' }}
              accept='image/jpg,impge/png,image/jpeg'
              name='profile_img'
              onChange={onChange}
              ref={fileInput}
            />
          </MyImg>

          <Id>{sessionId}</Id>

          <>
            <Nickname>{apiData.user.nickname}</Nickname>
            <>
              <Button>랜덤 버튼</Button>
              <Button>닉네임 변경</Button>
            </>
          </>

          <Pwd onChange={onChangePasswordHandler} value={password} />
          <ErrMsg>{passwordError && <small>{passwordError}</small>}</ErrMsg>

          <PwdConfirm onChange={onChangePasswordHandler} value={confirm} />
          <Button onClick={onClickPasswordHandler}>비밀번호 변경</Button>
          <ErrMsg>{confirmError && <small>{confirmError}</small>}</ErrMsg>

          <Adiv>
            <Edit onClick={onOpenPopup}>회원을 탈퇴하시겠습니까?</Edit>
            {popupOn ? <Popup /> : ''}
          </Adiv>
        </Form>
      </Warp>
    </>
  );
};

export default EditUserInfo;
