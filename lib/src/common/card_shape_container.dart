

part of common_lib;



class CardShapeContainer extends StatelessWidget {

  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CardShapeContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromRGBO(223, 230, 238, 1),
            width: 1,
          ),
          boxShadow:[
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 0.1,
                offset: const Offset(2, 2)
            )
          ]
      ),
      child: child,
    );
  }
}