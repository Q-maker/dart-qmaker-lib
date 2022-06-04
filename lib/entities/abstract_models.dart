abstract class Describable {
    String? getDescription();
}

abstract class TitleHolder {
    String? getTitle();
}

abstract class IconHolder {
    String? getIconUri();
}

abstract class IdHolder<T> {
    T? getId();
}

abstract class StringIdHolder extends IdHolder<String> {

}

abstract class Itemizable with Describable, TitleHolder {

}

abstract class IconItem extends Itemizable with IconHolder {

}