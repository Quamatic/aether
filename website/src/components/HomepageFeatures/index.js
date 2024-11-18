import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Smart Positioning',
    description: (
      <>
        Aether allows you to position a floating element next to another element while making sure it stays in view by <b>avoiding collisions</b>.
        This lets you position tooltips, popovers, or dropdowns optimally.
      </>
    ),
  },
  {
    title: 'Customizable Middleware',
    description: (
      <>
        Aether provides middleware that lets you to tailor the behavior of any element in order to fit your needs.
      </>
    ),
  },
  {
    title: 'UI Framework Compatibility',
    description: (
      <>
        Aether provides different packages to provide compatability for multiple UI libraries, such as vide and react-lua!.
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      {/* <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div> */}
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
