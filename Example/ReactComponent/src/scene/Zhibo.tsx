import React, {useRef} from 'react';
import {
  StyleSheet,
  View,
  Dimensions,
  Image,
  TouchableOpacity,
  GestureResponderEvent,
  Animated,
} from 'react-native';

import Video from 'react-native-video';

// const dp2px = (dp: number) => PixelRatio.getPixelSizeForLayoutSize(dp);
// const px2dp = (px: number) => PixelRatio.roundToNearestPixel(px);
const {height: dvHeight} = Dimensions.get('window');

// const pxRatio = PixelRatio.get();

export interface Props {
  name: string;
}

console.log('dvHeight=', dvHeight);

const icoList = [
  require('./assets/icon_fan.png'),
  require('./assets/icon_lion.png'),
  require('./assets/icon_bao.png'),
];

const heartList = [
  // require('./assets/heart_0.png'),
  // require('./assets/heart_1.png'),
  // require('./assets/heart_2.png'),
  // require('./assets/heart_3.png'),
  // require('./assets/heart_4.png'),
];

const rocketList = [
  // require('./assets/rocket_0.png'),
  // require('./assets/rocket_1.png'),
  // require('./assets/rocket_2.png'),
  // require('./assets/rocket_3.png'),
  // require('./assets/rocket_4.png'),
  // require('./assets/rocket_5.png'),
  // require('./assets/rocket_6.png'),
];

const FadeInView: React.FC<Props> = (props) => {
  const fadeAnim = useRef(new Animated.Value(1)).current; // 透明度初始值设为0
  // const [rx, setRx] = useState(0);
  // const [ry, setRy] = useState(500);

  React.useEffect(() => {
    // console.log('ff');
    Animated.loop(
      Animated.timing(
        // 随时间变化而执行动画
        fadeAnim,
        {
          useNativeDriver: true,
          toValue: 0,
          duration: 1000 + Math.ceil(Math.random() * 1000), // 让动画持续一段时间
        },
      ),
    ).start(); // 开始执行动画
  }, [fadeAnim]);

  return (
    <Animated.View // 使用专门的可动画化的View组件
      style={{
        ...props.style,
        opacity: fadeAnim, // 将透明度绑定到动画变量值
      }}>
      {props.children}
    </Animated.View>
  );
};

const Zhibo: React.FC<Props> = () => {
  const onTapIcon = (e: GestureResponderEvent) => {
    console.log('eee', e);
  };

  const renderRocket = () => {
    const bb = rocketList
      .slice(0)
      .concat(rocketList)
      .concat(rocketList)
      .concat(rocketList)
      .concat(rocketList)
      .concat(rocketList);
    return bb.map((el, idx) => {
      return (
        <FadeInView
          key={idx}
          style={{
            ...styles.heartFrame,
            left: Math.ceil(Math.random() * 375),
            top: 200 + Math.ceil(Math.random() * 400),
          }}>
          <Image
            source={el}
            style={{
              width: 50,
              height: 50,
            }}
          />
        </FadeInView>
      );
    });
  };

  const renderHeart = () => {
    const bb = heartList
      .slice(0)
      .concat(heartList)
      .concat(heartList)
      .concat(heartList)
      .concat(heartList)
      .concat(heartList);
    return bb.map((el, idx) => {
      return (
        <FadeInView
          key={idx}
          style={{
            ...styles.heartFrame,
            left: Math.ceil(Math.random() * 375),
            top: 400 + Math.ceil(Math.random() * 200),
          }}>
          <Image
            source={el}
            style={{
              width: 50,
              height: 50,
            }}
          />
        </FadeInView>
      );
    });
  };

  const renderIcon = () => {
    return icoList.map((el, idx) => {
      return (
        <TouchableOpacity
          onPress={onTapIcon}
          key={idx}
          style={{
            flex: 1,
            display: 'flex',
            flexDirection: 'row',
            justifyContent: 'center',
            ...styles.tbd,
          }}>
          <Image
            source={el}
            style={{
              ...styles.tabBtn,
              ...styles.tbd,
            }}
          />
        </TouchableOpacity>
      );
    });
  };
  return (
    <View style={styles.sceneFrame}>
      <View style={styles.vFrame}>
        <Video
          // source={{uri: 'http://127.0.0.1:5000/Documents/test1.mp4'}} // Can be a URL or a local file.
          source={{
            uri:
              'https://vd4.bdstatic.com/mda-mbqbcvafw3w6cmr2/v1-cae/mda-mbqbcvafw3w6cmr2.mp4?v_from_s=nj_videoui_4135&auth_key=1614234486-0-0-0f3fefa24adb6cf6ce1c1d22f183bef6&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=3000156_3-8_2',
            // 'http://cdnori.leanteq.cn/asserts/img/test1rn.mp4',
            // 'http://127.0.0.1:5000/Documents/test1.mp4',
          }} // Can be a URL or a local file.
          style={styles.backgroundVideo}
          resizeMode="cover"
          repeat
        />
      </View>
      <View
        style={{
          ...styles.vTab,
          marginTop: dvHeight - 100,
        }}>
        <View style={styles.tabBg} />
        <View
          style={{
            position: 'absolute',
            top: 0,
            width: '100%',
            height: '100%',
            ...styles.tbd,
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'center',
          }}>
          <View
            style={{
              flex: 1,
              width: '100%',
              display: 'flex',
              flexDirection: 'row',
              justifyContent: 'center',
            }}>
            {renderIcon()}
          </View>
        </View>
      </View>
      {renderHeart()}
      {renderRocket()}
    </View>
  );
};

const styles = StyleSheet.create({
  heartFrame: {
    position: 'absolute',
    zIndex: 20,
    width: 50,
    height: 50,
  },
  tbd: {
    // borderWidth: 1,
    // borderColor: 'red',
  },
  sceneFrame: {
    height: '100%',
    width: '100%',
  },
  vFrame: {
    height: '100%',
    width: '100%',
  },
  vTab: {
    position: 'absolute',
    zIndex: 10,
    width: '100%',
    height: 100,
  },
  tabBtn: {
    width: 50,
    height: 50,
    marginTop: 15,
    resizeMode: 'contain',
  },
  tabBg: {
    width: '100%',
    height: 100,
    backgroundColor: 'grey',
    opacity: 0.2,
  },
  backgroundVideo: {
    position: 'absolute',
    zIndex: 5,
    top: 0,
    left: 0,
    bottom: 0,
    right: 0,
  },
});
export default Zhibo;
