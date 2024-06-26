import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';
import '../globalStyle';
import boogicard from '../images/bogimon_card_b.png';
import Header from '../Components/Header';
import Button from '../Components/Button';
import html2canvas from 'html2canvas';
import boogi from '../boogi';
import StampBook from '../Components/StampBook';
import logo from '../images/logo.png';
import avatar from '../images/avatar.png';

const Modal = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1000;
`;

const PopupBg = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.6);
`;

const CloseBtn = styled.button`
  position: absolute;
  width: 40px;
  height: 20px;
  left: 90%;
  border: 2px solid var(--gray2);
  border-radius: 4px;
  background-color: #ffffff;
  box-sizing: border-box;
  &:hover {
    cursor: pointer;
    background-color: var(--yellow);
    border: 2px solid var(--light-blue);
  }
`;

const OpenBtn = styled.button`
  border: 2px solid var(--gray2);
  border-radius: 4px;
  background-color: #ffffff;
  padding: 8px 25px;
  box-sizing: border-box;
  &:hover {
    cursor: pointer;
    background-color: var(--yellow);
    border: 2px solid var(--light-blue);
  }
`;

const BoogiCardContainer = styled.div`
  width: 290px;
  height: 400px;
  position: absolute;
  left: 15%;
  top: 5%;
  z-index: 2; /* 보다 낮은 z-index 값을 설정 */
  background-image: url(${boogicard});
  background-size: cover; /* 이미지를 컨테이너에 맞게 조절 */
  background-position: center; /* 이미지를 가운데 정렬 */
`;

const CardPopup = styled.div`
  position: fixed; /* 화면 크기에 관계없이 위치 고정 */
  top: 50%; /* 화면 상단에서 50% 위치에 배치 */
  left: 50%; /* 화면 왼쪽에서 50% 위치에 배치 */
  transform: translate(-50%, -50%); /* 중앙 정렬을 위한 변환 */
  background-color: #ffffff;
  box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);

  /* 임시 지정 */
  width: 400px;
  height: 500px;

  /* 초기에 약간 아래에 배치 */
  transform: translate(-50%, -40%);

  white-space: normal;
  border-radius: 10px;
`;

const Download = styled.div`
  position: absolute;
  top: 85%;
  left: 40%;
  width: 80px;
  height: 30px;
`;

const DownloadBtn = styled.button`
  width: 100px;
  height: 40px;
  position: absolute;
  left: -15%;
  top: 55%;
  background-color: transparent;
  color: var(--black); /* 텍스트 색상 설정 */
  font-size: var(--small);
  text-decoration: none solid rgb(21, 23, 26);
  vertical-align: middle;
  padding: 10px 20px;
  cursor: pointer;
  outline: none;
  filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25)); /* 그림자 효과 추가 */
  border: 3px solid transparent; /* 테두리 색상 초기화 */
  border-image: linear-gradient(45deg, #72bab3, #eccf63) 1; /* 그라데이션 테두리 추가 */
  border-image-slice: 1;
  transform: skew(-20deg);
  &::before {
    content: '다운로드';
    display: block;
    transform: skewX(20deg); /* 텍스트를 반대로 기울이지 않습니다 */
  }
`;

const CardName = styled.p`
  width: 130px;
  height: 25px;
  position: absolute;
  left: 26%;
  top: 2%;
  z-index: 2; /* 더 높은 z-index 값을 설정하여 앞으로 가져옵니다 */
`;

const RandomImg = styled.div`
  width: 240px;
  height: 150px;
  position: absolute;
  left: 8%;
  top: 14%;
  z-index: 3; /* 더 높은 z-index 값을 설정하여 앞으로 가져옵니다 */
  background-size: 100% 100%;
  background-repeat: no-repeat; /* 이미지 반복 방지 */
  background-position: center; /* 이미지를 가운데 정렬 */
  border-radius: 50%;
`;

const CardContent = styled.p`
  width: 260px;
  height: 140px;
  position: absolute;
  left: 5%;
  top: 51%;
  z-index: 3; /* 더 높은 z-index 값을 설정하여 앞으로 가져옵니다 */
`;

const MainImg = styled.div`
  width: 260px;
  height: 80px;
  position: absolute;
  left: 6%;
  top: 65%;
  z-index: 3; /* 더 높은 z-index 값을 설정하여 앞으로 가져옵니다 */
  background-image: url(${logo});
  background-size: 90% 90%;
  background-repeat: no-repeat; /* 이미지 반복 방지 */
  background-position: center; /* 이미지를 가운데 정렬 */
`;

const RegDates = styled.div`
  width: 240px;
  height: 25px;
  position: absolute;
  left: 10%;
  top: 90%;
  z-index: 3; /* 더 높은 z-index 값을 설정하여 앞으로 가져옵니다 */
  border-color: var(--yellow);
`;

const Mypage = styled.div`
  position: relative;
  height: 250px;
  width: 1280px;
  margin: 30px auto 0; /* 위에 30px의 margin 추가 */
  border-radius: 10px;
  border: 1px solid var(--gray2);
`;

const CompleteBtn = styled.div`
  text-align: center;
  & > button {
    display: inline-block;
    border: 2px solid var(--gray2);
    border-radius: 4px;
    background-color: #ffffff;
    padding: 8px 25px;
    box-sizing: border-box;
  }
  & > button:hover {
    cursor: pointer;
    background-color: var(--yellow);
    border: 2px solid var(--light-blue);
  }
`;

const Wrap = styled.div`
  width: 1280px;
  margin: 0 auto;
`;

const Sort = styled.select`
  width: 100px;
  border: 1px solid var(--gray2);
  border-radius: 5px;
  padding: 5px 8px;
  box-sizing: border-box;
  margin-top: 30px;
  &:hover {
    cursor: pointer;
  }
`;

const StampBookBox = styled.section`
  display: flex;
  flex-wrap: wrap;
  margin-top: 20px;
  > div {
    margin-right: 25px;
    margin-bottom: 30px;
  }
  > div:nth-child(3n) {
    margin-right: 0;
  }
  &:hover {
    cursor: pointer;
  }
`;

const MyImg = styled.div`
  width: 120px;
  height: 120px;
  background-color: white;
  border-radius: 50%;
  position: absolute;
  top: 25%;
  left: 80px;
  overflow: hidden;
  background-color: var(--gray2);
`;

const MyProfileImg = styled.img`
  width: 120px;
  height: 120px;
  object-fit: cover;
`;

const MyproFile = styled.div`
  width: 240px;
  height: 200px;
  position: absolute;
  top: 10%; /* 원하는 위쪽 위치 (예: 100px) */
  left: 250px; /* 원하는 왼쪽 위치 (예: 200px) */
  display: flex;
  align-items: center; /* 수직 가운데 정렬 */
  justify-content: center; /* 수평 가운데 정렬 */
  text-align: center; /* 텍스트를 가운데 정렬 */
`;

const NickName = styled.p`
  position: absolute;
  font-size: var(--big);
  top: 20%;
`;

const MyProgress = styled.div`
  width: 670px;
  height: 200px;
  position: absolute;
  top: 10%; /* 원하는 위쪽 위치 (예: 100px) */
  left: 550px; /* 원하는 왼쪽 위치 (예: 200px) */
`;

const Rank = styled.p`
  position: absolute;
  font-size: var(--big);
  top: 40px;
  left: 5%;
  text-align: center; /* 텍스트를 가운데 정렬 */
`;

const Level = styled.p`
  position: absolute;
  font-size: var(--big);
  top: 40px;
  right: 45px;
  text-align: center; /* 텍스트를 가운데 정렬 */
`;

const Progress = styled.progress`
  position: absolute;
  top: 50%;
  left: 5%;
  width: 600px;
  appearance: none;
  &::-webkit-progress-bar {
    /* progressbar의 배경이 되는 요소 */
    background: #f0f0f0;
    border-radius: 10px;
    box-shadow: inset 3px 3px 10px #ccc;
  }
  &::-webkit-progress-value {
    /* 텍스트를 가운데 정렬 */
    border-radius: 10px;
    background: var(--magenta);
    background: -webkit-linear-gradient(
      to right,
      var(--light-blue),
      var(--magenta)
    );
    background: linear-gradient(to right, var(--light-blue), var(--magenta));
  }
`;

const StampComplete = styled.p`
  position: absolute;
  font-size: var(--regular);
  top: 70%;
  left: 5%;
  text-align: center; /* 텍스트를 가운데 정렬 */
`;

const UserLike = styled.p`
  position: absolute;
  font-size: var(--regular);
  top: 80%;
  left: 5%;
  text-align: center; /* 텍스트를 가운데 정렬 */
`;

const Exp = styled.p`
  position: absolute;
  font-size: var(--regular);
  top: 70%;
  left: 78%;
  text-align: center; /* 텍스트를 가운데 정렬 */
`;

const My = () => {
  const [openCard, closeCard] = useState(false);
  const [apiData, setApiData] = useState({ user: [] });
  const [data, setData] = useState([]);
  const [sort, setSort] = useState('new'); // 기본값을 최신순으로 설정

  const onOpenCard = () => {
    closeCard(!openCard);
  };

  const Popup = () => {
    const saveAsImage = () => {
      const cardElement = document.querySelector('.CardPopup');
      html2canvas(cardElement).then((canvas) => {
        // 사용자로부터 파일 이름을 입력받기 위한 프롬프트 다이얼로그
        const filename = window.prompt(
          'Enter a filename',
          'custom_image_name.png'
        );

        // 사용자가 취소 버튼을 누르면 null이 반환되므로 확인
        if (filename !== null) {
          const link = document.createElement('a');
          link.download = filename; // 사용자가 입력한 파일 이름 설정
          link.href = canvas.toDataURL();
          link.click();
        }
      });
    };

    return (
      <Modal>
        <PopupBg />
        <CardPopup>
          <CloseBtn onClick={onOpenCard} data-html2canvas-ignore='true'>
            {' '}
            닫기
          </CloseBtn>
          <BoogiCardContainer className='CardPopup'>
            <CardName>BOOGIMON</CardName>
            <RandomImg>
              <MyProfileImg src={apiData.user.profileImg} alt='프로필이미지' />
            </RandomImg>
            <CardContent>
              {apiData.user.nickname ? apiData.user.nickname : '-'} 님<hr />
              부기몬의 세계로 오신것을 환영합니다!
            </CardContent>
            <MainImg />
            <RegDates>가입일: {apiData.user.regdate}</RegDates>
          </BoogiCardContainer>
          <Download>
            <DownloadBtn
              onClick={saveAsImage}
              data-html2canvas-ignore='true'
            ></DownloadBtn>
          </Download>
        </CardPopup>
      </Modal>
    );
  };

  const View = () => {
    return (
      <Mypage>
        <MyImg>
          <MyProfileImg
            src={apiData.user.profileImg ? apiData.user.profileImg : avatar}
            alt='프로필이미지'
          />
        </MyImg>
        <MyproFile>
          <NickName>
            {apiData?.user.nickname ? apiData.user.nickname : '-'}
          </NickName>
          <Link to='/edituserinfo'>
            <Button
              style={{
                position: 'absolute',
                top: '120px',
                left: '58px',
                textAlign: 'center',
              }}
            >
              회원정보 수정
            </Button>
          </Link>
          <CompleteBtn>
            {/* <OpenBtn onClick={onOpenCard}>부기몬 카드</OpenBtn> */}
            {openCard && <Popup />}
          </CompleteBtn>
        </MyproFile>
        <MyProgress>
          <Rank>
            Rank <b style={{ marginLeft: '10px' }}>{apiData?.user.ranking}</b>
            <small> th</small>
          </Rank>
          <Level>
            <span style={{ marginRight: '10px' }}>LV.</span>
            {apiData?.user.exp < 1000
              ? 1
              : Math.floor(apiData?.user.exp / 1000) + 1}
          </Level>
          <Progress
            value={!isNaN(apiData?.user.exp) ? apiData.user.exp % 1000 : 0}
            min='0'
            max='1000'
          />
          <StampComplete>
            <span style={{ marginRight: '10px' }}>모은 스탬프</span>{' '}
            {apiData?.user.userTotalVisit} 개
          </StampComplete>
          <UserLike>
            <span style={{ marginRight: '10px' }}>받은 좋아요</span>{' '}
            {apiData?.user.userLikeCount} 개
          </UserLike>
          <Exp>
            <span style={{ marginRight: '10px' }}>EXP.</span>
            {apiData?.user.exp % 1000}/1000
          </Exp>
        </MyProgress>
      </Mypage>
    );
  };

  const handleSortChange = (e) => {
    const selectedSort = e.target.value;
    setSort(selectedSort);
  };

  const sortedStampBooks = () => {
    const sortedBooks = [...data];
    if (sort === 'popular') {
      sortedBooks.sort((a, b) => b.likeCount - a.likeCount);
    } else if (sort === 'new') {
      sortedBooks.sort(
        (a, b) => new Date(b.stampbookRegdate) - new Date(a.stampbookRegdate)
      );
    } else if (sort === 'abc') {
      sortedBooks.sort((a, b) => a.title.localeCompare(b.title));
    }
    return sortedBooks;
  };

  useEffect(() => {
    // user 정보
    boogi
      .get(
        `/boogimon/user/user.jsp?userId=${window.sessionStorage.getItem(
          'userId'
        )}`
      )
      .then((response) => {
        setApiData(response.data);
      });

    // user가 pick한 스탬프북 리스트
    boogi
      .get(
        `/boogimon/stampbook/stampbook.jsp?command=mylist&userId=${window.sessionStorage.getItem(
          'userId'
        )}`
      )
      .then((response) => {
        setData(response.data?.stampbookList || []);
      });
  }, []);

  return (
    <div>
      <Header />
      <View />
      <Wrap>
        <Sort onChange={handleSortChange} value={sort}>
          <option value='popular'>인기순</option>
          <option value='new'>최신순</option>
          <option value='abc'>가나다순</option>
        </Sort>
        <StampBookBox>
          {sortedStampBooks().map((book, i) => {
            return (
              <StampBook
                stampbookid={book.stampbookId}
                ispick={book.isPick}
                islike={book.isLike}
                likecount={book.likeCount}
                title={book.title}
                stamplist={book.stampList}
                key={i}
              />
            );
          })}
        </StampBookBox>
      </Wrap>
    </div>
  );
};

export default My;
