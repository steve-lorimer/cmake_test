#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QPushButton>
#include <QMessageBox>
#include "lib2/lib2.h"

class App
{
public:
    App(int& argc, char** argv)
        : app(argc, argv)
    { }

    int exec()
    {
        window = new QMainWindow();

        QWidget* widget = new QWidget();
        window->setCentralWidget(widget);
        widget->setLayout(&layout);

        QPushButton* button = new QPushButton("go");
        QObject::connect(button, &QPushButton::clicked, [&](){ onGo(); });
        layout.addWidget(button);

        window->show();
        return app.exec();
    }

    void onGo()
    {
        QMessageBox(
            QMessageBox::Icon::Information,
            "lib2 output",
            QString::fromStdString(lib2()),
            QMessageBox::StandardButton::NoButton,
            window).exec();
    }


    QApplication app;
    QMainWindow* window;
    QVBoxLayout  layout;
};

int main(int argc, char** argv)
{
    return App(argc, argv).exec();
}


