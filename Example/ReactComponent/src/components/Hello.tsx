// components/Hello.tsx
import React from 'react';
import {
  Button,
  StyleSheet,
  Text,
  View,
  Dimensions,
  PixelRatio,
} from 'react-native';

const dp2px = (dp: number) => PixelRatio.getPixelSizeForLayoutSize(dp);
const px2dp = (px: number) => PixelRatio.roundToNearestPixel(px);
const {width, height} = Dimensions.get('window');
const pxRatio = PixelRatio.get();

const designSize = {width: 750, height: 1336};

export interface Props {
  name: string;
  enthusiasmLevel?: number;
}

const Hello: React.FC<Props> = (props) => {
  const [enthusiasmLevel, setEnthusiasmLevel] = React.useState(
    props.enthusiasmLevel,
  );

  const onIncrement = () => setEnthusiasmLevel((enthusiasmLevel || 0) + 1);
  const onDecrement = () => {
    if ((enthusiasmLevel || 0) < 0) {
      setEnthusiasmLevel(0);
    } else {
      setEnthusiasmLevel((enthusiasmLevel || 0) - 1);
    }
  };

  const getExclamationMarks = (numChars: number) => {
    return Array(numChars > 0 ? numChars + 1 : 0).join('!');
  };
  return (
    <View style={styles.root}>
      <Text style={styles.greeting}>
        Hello {props.name + getExclamationMarks(enthusiasmLevel || 0)}
      </Text>
      <View>
        <Text>device {`${width} x ${height} | ${pxRatio}`}</Text>
      </View>

      <View style={styles.buttons}>
        <View style={styles.button}>
          <Button
            title="-"
            onPress={onDecrement}
            accessibilityLabel="decrement"
            color="red"
          />
        </View>

        <View style={styles.button}>
          <Button
            title="+"
            onPress={onIncrement}
            accessibilityLabel="increment"
            color="blue"
          />
        </View>
      </View>
    </View>
  );
};

// styles
const styles = StyleSheet.create({
  root: {
    alignItems: 'center',
    alignSelf: 'center',
  },
  buttons: {
    flexDirection: 'row',
    minHeight: 70,
    alignItems: 'stretch',
    alignSelf: 'center',
    width: 375,
    borderWidth: 1,
  },
  button: {
    flex: 1,
    paddingVertical: 0,
  },
  greeting: {
    color: 'green',
    fontWeight: 'bold',
  },
});

export default Hello;
